import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/themes.dart';

class ThemeRepository{
  bool get getThemeStatus => _isDarkMode;

  ThemeData get getTheme => _isDarkMode ? darkTheme : lightTheme;

  bool _isDarkMode = false;

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
  }
}