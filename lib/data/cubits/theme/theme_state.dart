part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeData? theme;
  final bool themeStatus;

  ThemeState({
    required this.theme,
    required this.themeStatus,
  });

  @override
  List<Object?> get props => [theme, themeStatus];
}
