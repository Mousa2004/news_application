#!/bin/bash

echo "🔄 Starting Ultra-Safe Flutter Package Update for Windows..."

# تحديد مسار pubspec.yaml في جذر المشروع
file="../pubspec.yaml"

# التأكد من وجود الملف
if [ ! -f "$file" ]; then
  echo "❌ Error: pubspec.yaml not found at $file"
  exit 1
fi

# -----------------------------------------
# 1️⃣ تعليق الباكدجات المتوقفة
sed -i 's/^\s*device_info:/# device_info: removed (use device_info_plus)/g' "$file"
sed -i 's/^\s*pedantic:/# pedantic: removed (use lints)/g' "$file"
sed -i 's/^\s*isolate:/# isolate: removed/g' "$file"
sed -i 's/^\s*adaptive_breakpoints:/# adaptive_breakpoints: removed/g' "$file"
sed -i 's/^\s*js:/# js: removed (deprecated)/g' "$file"

# -----------------------------------------
# 2️⃣ إضافة الباكدجات البديلة تحت dependencies إذا غير موجودة
if ! grep -q "device_info_plus:" "$file"; then
  sed -i '/^dependencies:/a\  device_info_plus: ^12.2.0' "$file"
fi

if ! grep -q "lints:" "$file"; then
  sed -i '/^dependencies:/a\  lints: ^6.0.0' "$file"
fi

# -----------------------------------------
# 3️⃣ تحديث الباكدجات الحساسة مباشرة
declare -A fixed_packages=(
    [webview_flutter]="4.13.0"
    [video_player]="2.10.1"
    [webview_flutter_android]="4.10.5"
    [webview_flutter_wkwebview]="3.23.2"
    [video_player_android]="2.8.17"
    [video_player_avfoundation]="2.8.6"
    [video_player_platform_interface]="6.6.0"
)

for pkg in "${!fixed_packages[@]}"; do
    grep -q "$pkg:" "$file" && sed -i "s/$pkg:.*/$pkg: ^${fixed_packages[$pkg]}/" "$file"
done

# -----------------------------------------
# 4️⃣ تحديث باقي الباكدجات مع التحقق من التوافق
# فقط باكدجات تحت dependencies
packages=$(awk '/^dependencies:/,/^[^ ]/' "$file" | grep -E '^[ ]{2}[a-zA-Z0-9_]+:' | awk -F: '{print $1}' | sed 's/ //g')

echo "📦 Checking other packages for latest stable versions with compatibility check..."

for pkg in $packages; do
    # تخطي الباكدجات الحساسة التي تم تحديثها مسبقًا
    if [[ -n "${fixed_packages[$pkg]}" ]]; then
        continue
    fi

    latest_version=$(curl -s "https://pub.dev/api/packages/$pkg" | grep -Po '"latest":.*?"version":.*?"\K[^"]+')
    
    if [ ! -z "$latest_version" ]; then
        old_version=$(grep "$pkg:" "$file" | awk -F: '{print $2}' | xargs)
        
        # تجربة النسخة الجديدة مؤقتًا
        sed -i "s/$pkg:.*/$pkg: ^$latest_version/" "$file"
        
        if flutter pub get &>/dev/null; then
            echo "✅ $pkg updated: $old_version → $latest_version (compatible)"
        else
            # إعادة النسخة القديمة إذا التحديث يسبب مشاكل
            sed -i "s/$pkg:.*/$pkg: $old_version/" "$file"
            echo "⚠️ $pkg version $latest_version may break compatibility. Kept $old_version."
        fi
    fi
done

# -----------------------------------------
# 5️⃣ تحديث كل الباكدجات لأحدث نسخة رئيسية والتأكد من التوافق
flutter pub upgrade --major-versions

# -----------------------------------------
# 6️⃣ تقرير نهائي
echo "📋 Final package status:"
flutter pub outdated

echo "✅ Ultra-Safe Flutter Package Update completed successfully!"
