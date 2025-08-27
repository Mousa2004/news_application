import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/shared/view_model/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingTheme extends Cubit<ThemeState> {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isLight => themeMode == ThemeMode.light;

  SettingTheme() : super(InitialThemeState(ThemeMode.dark)) {
    loadTheme();
  }

  void changeTheme(ThemeMode theme) async {
    themeMode = theme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "themeMode",
      themeMode == ThemeMode.light ? "light" : "dark",
    );
    emit(ChangeThemeState(themeMode));
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString("themeMode");

    if (savedTheme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    emit(LoadThemeState(themeMode));
  }
}
