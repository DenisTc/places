import 'package:flutter/material.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/ui/res/themes.dart';

class ThemeApp extends ChangeNotifier {
  SharedStorage _storage = SharedStorage();
  bool _isDark = false;

  bool get isDark => _isDark;
  ThemeData get getTheme => isDark ? darkTheme : lightTheme;

  ThemeApp() {
    initTheme();
  }

  set setThemeState(bool value) {
    _isDark = value;
    _storage.setTheme(_isDark);
    notifyListeners();
  }

  initTheme() async {
    _isDark = await _storage.getTheme();
    notifyListeners();
  }

  Future<void> switchTheme() async {
    setThemeState = !_isDark;
    notifyListeners();
  }
}
