import 'package:places/data/redux/action/filtered_places_action.dart';
import 'package:places/data/redux/action/place_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:redux/redux.dart';

class PlaceMiddleware implements MiddlewareClass<AppState> {
  final PlaceRepository _placeRepository;

  PlaceMiddleware(this._placeRepository);

  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is LoadPlaceDetailsAction) {
      _placeRepository
          .getPlaceDetails(id: action.id)
          .then((result) => store.dispatch(ResultPlaceDetailsAction(result)))
          .catchError(
              (errMsg) => store.dispatch(ErrorPlaceAction(errMsg.toString())));
    }
    next(action);
  }
}
