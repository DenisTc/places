import 'package:places/data/redux/action/theme_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/repository/theme_repository.dart';
import 'package:redux/redux.dart';

class ThemeMiddleware implements MiddlewareClass<AppState> {
  final ThemeRepository themeRepository;

  ThemeMiddleware(this.themeRepository);

  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) async {


    if (action is ToggleThemeAction) {
      
      await themeRepository.changeTheme();

      final theme = await themeRepository.getTheme;
      final themeStatus = await themeRepository.getThemeStatus;
      
      return store.dispatch(ResultToggleThemeAction(theme,themeStatus));
      
    }

    next(action);
  }
}
