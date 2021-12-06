import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/data/repository/theme_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository themeRepository;

  ThemeBloc(this.themeRepository)
      : super(
          ThemeState(
            theme: themeRepository.getTheme,
            themeStatus: themeRepository.getThemeStatus,
          ),
        ) {
    on<ToggleTheme>(
      (event, emit) => _toggleTheme(event, emit),
    );
  }

  void _toggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    themeRepository.changeTheme();

    final theme = await themeRepository.getTheme;
    final themeStatus = await themeRepository.getThemeStatus;

    emit(
      ThemeState(theme: theme, themeStatus: themeStatus),
    );
  }
}
