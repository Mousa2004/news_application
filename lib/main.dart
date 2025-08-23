import 'package:flutter/material.dart';
import 'package:news_application/apptheme.dart';
import 'package:news_application/home_screen.dart';
import 'package:news_application/news/search_screen.dart';
import 'package:news_application/provider/setting_theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingThemeProvider settingThemeProvider =
        Provider.of<SettingThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routName,
      routes: {
        HomeScreen.routName: (_) => HomeScreen(),
        SearchScreen.routName: (_) => SearchScreen(),
      },
      theme: Apptheme.lightTheme,
      darkTheme: Apptheme.darkTheme,
      themeMode: settingThemeProvider.themeMode,
    );
  }
}
