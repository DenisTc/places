import 'package:flutter/material.dart';

/// Abstract class for interaction with theme
abstract class ThemeActions {}

/// Toggle theme
class ToggleThemeAction extends ThemeActions {}

/// Result of toggle theme
class ResultToggleThemeAction extends ThemeActions {
  final ThemeData theme;
  final bool themeStatus;

  ResultToggleThemeAction(this.theme, this.themeStatus);
}


