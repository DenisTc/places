import 'package:places/data/redux/action/filtered_places_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:redux/redux.dart';

class PlaceMiddleware implements MiddlewareClass<AppState> {
  final SearchRepository _searchRepository;

  PlaceMiddleware(this._searchRepository);

  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is LoadFilteredPlacesAction) {
      _searchRepository
          .getFiltredPlaces(action.filter)
          .then((result) => store.dispatch(ResultFilteredPlacesAction(result)))
          .catchError((errMsg) =>
              store.dispatch(ErrorFilteredPlacesAction(errMsg.toString())));

      // try {
      //   final result = await _searchRepository.getFiltredPlaces(action.filter).;
      //   return store.dispatch(ResultFilteredPlacesAction(result));
      // } catch (error) {
      //   return store.dispatch(ErrorFilteredPlacesAction(error.toString()));
      // }
    }
    next(action);
  }
}
