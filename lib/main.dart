import 'package:flutter/material.dart';
import 'package:news_application/apptheme.dart';
import 'package:news_application/home_screen.dart';
import 'package:news_application/news/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routName,
      routes: {
        HomeScreen.routName: (_) => HomeScreen(),
        SearchScreen.routName: (_) => SearchScreen(),
      },
      theme: Apptheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
