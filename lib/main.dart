import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:news_application/news/data/models/article.dart';
import 'package:news_application/shared/view/widget/app_block_observer.dart';
import 'package:news_application/shared/view/widget/apptheme.dart';
import 'package:news_application/home/views/screen/home_screen.dart';
import 'package:news_application/news/views/widget/search_screen.dart';
import 'package:news_application/shared/view_model/setting_theme.dart';
import 'package:news_application/shared/view_model/theme_state.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(SourceAdapter());
  Hive.registerAdapter(NewsAdapter());

  Bloc.observer = AppBlockObserver();
  final settingTheme = SettingTheme();
  await settingTheme.initTheme();
  runApp(BlocProvider(create: (context) => SettingTheme(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingTheme, ThemeState>(
      builder: (context, state) => ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        child: Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: HomeScreen.routName,
              routes: {
                HomeScreen.routName: (_) => HomeScreen(),
                SearchScreen.routName: (_) => SearchScreen(),
              },
              theme: Apptheme.lightTheme,
              darkTheme: Apptheme.darkTheme,
              themeMode: state.themeMode,
            );
          },
        ),
      ),
    );
  }
}
