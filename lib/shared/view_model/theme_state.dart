import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode themeMode;
  ThemeState(this.themeMode);
}

class InitialThemeState extends ThemeState {
  InitialThemeState(super.themeMode);
}

class ChangeThemeState extends ThemeState {
  ChangeThemeState(super.themeMode);
}

class LoadThemeState extends ThemeState {
  LoadThemeState(super.themeMode);
}
