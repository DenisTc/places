
import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/themes.dart';


class Settings extends ChangeNotifier{
  bool _isDarkMode = false;

  bool get getThemeValue => _isDarkMode;

  ThemeData get getTheme => _isDarkMode ? darkTheme : lightTheme;

  void changeTheme(bool newTheme) {
    _isDarkMode = newTheme;
    notifyListeners();
  }
}