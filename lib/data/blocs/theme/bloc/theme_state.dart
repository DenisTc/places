part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData theme;
  final bool themeStatus;
  const ThemeState({required this.theme, required this.themeStatus});

  @override
  List<Object> get props => [theme];
}