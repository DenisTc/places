import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';

class SettingsInteractor extends ChangeNotifier {
  bool get getThemeValue => _isDarkMode;

  ThemeData get getTheme => _isDarkMode ? darkTheme : lightTheme;

  bool _isDarkMode = false;

  void changeTheme({required bool toggleValue}) {
    _isDarkMode = toggleValue;
    notifyListeners();
  }
}
