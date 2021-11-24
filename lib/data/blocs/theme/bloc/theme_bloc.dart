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
        );

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    final theme = await themeRepository.getTheme;
    final themeStatus = await themeRepository.getThemeStatus;

    if (event is ToggleTheme) {
      themeRepository.changeTheme();
      if (theme is ThemeData) {
        yield ThemeState(theme: theme, themeStatus: themeStatus);
      }
    }
  }
}
