import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_application/shared/view/widget/apptheme.dart';
import 'package:news_application/home/views/screen/title_item.dart';
import 'package:news_application/shared/view_model/setting_theme.dart';
import 'package:provider/provider.dart';

class DrawerHome extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? resetSelected;
  const DrawerHome({super.key, this.resetSelected, this.onTap});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  List<String> themes = ["light", "dark"];
  List<Language> getLanguage = [
    Language(code: "en", lang: "English"),
    Language(code: "ar", lang: "Arabic"),
  ];

  @override
  Widget build(BuildContext context) {
    SettingTheme settingThemeProvider = Provider.of<SettingTheme>(context);
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7.w,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(color: Apptheme.black),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.sizeOf(context).height * 0.2.h,
            width: double.infinity,
            decoration: BoxDecoration(color: Apptheme.white),
            child: Text(
              "News App",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Apptheme.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                InkWell(
                  onTap:
                      widget.onTap ??
                      () {
                        widget.resetSelected!();
                        Navigator.of(context).pop();
                      },
                  child: TitleItem(icon: "home", text: "Go To Home"),
                ),
                SizedBox(height: 24.h),
                Divider(color: Apptheme.white),
                SizedBox(height: 24.h),
                TitleItem(icon: "theme", text: "Theme"),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Apptheme.white),
                  ),
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: Apptheme.grey,
                        borderRadius: BorderRadius.circular(16.r),
                      ),

                      offset: Offset(0, -2),
                    ),
                    iconStyleData: IconStyleData(
                      iconSize: 40,
                      iconEnabledColor: Apptheme.white,
                    ),
                    underline: SizedBox(),

                    value: settingThemeProvider.isLight ? "light" : "dark",
                    items: themes
                        .map(
                          (theme) => DropdownMenuItem<String>(
                            value: theme,
                            child: Text(
                              theme,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Apptheme.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (theme) {
                      if (theme == "light") {
                        settingThemeProvider.changeTheme(ThemeMode.light);
                      } else {
                        settingThemeProvider.changeTheme(ThemeMode.dark);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                Divider(color: Apptheme.white),
                SizedBox(height: 24.h),
                TitleItem(icon: "language", text: "Language"),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Apptheme.white),
                  ),
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: Apptheme.grey,
                        borderRadius: BorderRadius.circular(16.r),
                      ),

                      offset: Offset(0, -2),
                    ),
                    iconStyleData: IconStyleData(
                      iconSize: 40,
                      iconEnabledColor: Apptheme.white,
                    ),
                    underline: SizedBox(),

                    value: getLanguage[0].code,
                    items: getLanguage
                        .map(
                          (language) => DropdownMenuItem<String>(
                            value: language.code,
                            child: Text(
                              language.lang,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Apptheme.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Language {
  String code;
  String lang;
  Language({required this.code, required this.lang});
}
