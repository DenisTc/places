import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/ui/res/themes.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedStorage _storage;
  bool _themeStatus = false;
  ThemeData _currentTheme = lightTheme;

  bool get themeStatus => _themeStatus;
  ThemeData get getCurrentTheme => themeStatus ? darkTheme : lightTheme;

  ThemeCubit(this._storage)
      : super(ThemeState(theme: lightTheme, themeStatus: false)) {
    initTheme();
  }

  Future<void> initTheme() async {
    _themeStatus = await _storage.getTheme();

    emit(ThemeState(theme: _currentTheme, themeStatus: _themeStatus));
  }

  Future<void> switchTheme() async {
    saveTheme();
    _themeStatus = !_themeStatus;

    emit(ThemeState(theme: getCurrentTheme, themeStatus: themeStatus));
  }

  void saveTheme() {
    _storage.setTheme(isDark: _themeStatus);
  }
}
