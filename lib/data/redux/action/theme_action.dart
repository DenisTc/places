import 'package:flutter/material.dart';

/// Abstract class for interaction with theme
abstract class ThemeActions {}

class ResultToggleThemeAction extends ThemeActions {
  final ThemeData theme;
  final bool themeStatus;

  ResultToggleThemeAction(this.theme, this.themeStatus);
}

/// Toggle theme
class ToggleThemeAction extends ThemeActions {}
