import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isLight => themeMode == ThemeMode.light;

  SettingThemeProvider() {
    loadTheme();
  }
  void changeTheme(ThemeMode theme) async {
    themeMode = theme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "themeMode",
      themeMode == ThemeMode.light ? "light" : "dark",
    );
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString("themeMode");

    if (savedTheme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}
