import 'package:places/data/redux/action/favorite_places_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/domain/place.dart';
import 'package:redux/redux.dart';

class FavoriteMiddleware implements MiddlewareClass<AppState> {
  List<Place> favoriteList = [];

  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is LoadFavoritePlacesAction) {
      return store.dispatch(ResultFavoritePlacesAction(favoriteList));
    }

    if (action is ToggleInFavoriteAction) {
      if (favoriteList.contains(action.place)) {
        favoriteList.remove(action.place);
      } else {
        favoriteList.add(action.place);
      }

      return store.dispatch(ResultFavoritePlacesAction(favoriteList));
    }

    next(action);
  }
}
