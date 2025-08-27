import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/shared/view/widget/app_block_observer.dart';
import 'package:news_application/shared/view/widget/apptheme.dart';
import 'package:news_application/home/views/screen/home_screen.dart';
import 'package:news_application/news/views/widget/search_screen.dart';
import 'package:news_application/shared/view_model/setting_theme.dart';
import 'package:news_application/shared/view_model/theme_state.dart';

void main() async {
  Bloc.observer = AppBlockObserver();

  runApp(BlocProvider(create: (context) => SettingTheme(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingTheme, ThemeState>(
      builder: (context, state) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routName,
        routes: {
          HomeScreen.routName: (_) => HomeScreen(),
          SearchScreen.routName: (_) => SearchScreen(),
        },
        theme: Apptheme.lightTheme,
        darkTheme: Apptheme.darkTheme,
        themeMode: state.themeMode,
      ),
    );
  }
}
