import 'package:places/data/redux/action/favorite_places_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/favorite_places_state.dart';

AppState loadFavoritePlacesReducer(AppState state, LoadFavoritePlacesAction action){
  return state.copyWith(favoritePlacesState: FavoritePlacesLoadingState());
}

AppState resultFavoritePlacesReducer(AppState state, ResultFavoritePlacesAction action){
  return state.copyWith(favoritePlacesState: FavoritePlacesDataState(action.places));
}