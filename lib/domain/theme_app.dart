// ignore_for_file: always_declare_return_types, type_annotate_public_apis, avoid_setters_without_getters

import 'package:flutter/material.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/ui/res/themes.dart';

class ThemeApp extends ChangeNotifier {
  final SharedStorage _storage = SharedStorage();

  set setThemeState(bool value) {
    _isDark = value;
    _storage.setTheme(isDark: _isDark);
    notifyListeners();
  }

  bool _isDark = false;

  // ignore: member-ordering-extended
  bool get isDark => _isDark;
  // ignore: member-ordering-extended
  ThemeData get getTheme => isDark ? darkTheme : lightTheme;

  ThemeApp() {
    initTheme();
  }

  Future<void> initTheme() async {
    _isDark = await _storage.getTheme();
    notifyListeners();
  }

  Future<void> switchTheme() async {
    setThemeState = !_isDark;
    notifyListeners();
  }
}
