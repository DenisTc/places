part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final ThemeData theme;
  final bool themeStatus;
  const ThemeState({required this.theme, required this.themeStatus});

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  ThemeInitial(ThemeData theme, bool themeStatus)
      : super(theme: theme, themeStatus: themeStatus);
}

class ThemeChenging extends ThemeState {
  final ThemeData theme;
  final bool themeStatus;

  const ThemeChenging({required this.theme, required this.themeStatus})
      : super(theme: theme, themeStatus: themeStatus);

  @override
  List<Object> get props => [theme];
}
