import 'package:places/data/redux/action/theme_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/theme_state.dart';

AppState toggleThemeReducer(AppState state, ResultToggleThemeAction action) {
  return state.copyWith(
    themeState: ThemeState(
      theme: action.theme,
      themeStatus: action.themeStatus,
    ),
  );
}
