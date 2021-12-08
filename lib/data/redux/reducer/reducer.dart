import 'package:places/data/redux/action/favorite_places_action.dart';
import 'package:places/data/redux/action/filtered_places_action.dart';
import 'package:places/data/redux/action/place_action.dart';
import 'package:places/data/redux/action/theme_action.dart';
import 'package:places/data/redux/reducer/favorite_places_reducer.dart';
import 'package:places/data/redux/reducer/filtered_places_reducer.dart';
import 'package:places/data/redux/reducer/place_reducer.dart';
import 'package:places/data/redux/reducer/theme_reducer.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:redux/redux.dart';

final reducerApp = combineReducers<AppState>([
  TypedReducer<AppState, LoadFilteredPlacesAction>(loadFilteredPlacesReducer),
  TypedReducer<AppState, ErrorFilteredPlacesAction>(errorFilteredPlacesReducer),
  TypedReducer<AppState, ResultFilteredPlacesAction>(resultFilteredPlacesReducer),
  
  TypedReducer<AppState, LoadFavoritePlacesAction>(loadFavoritePlacesReducer),
  TypedReducer<AppState, ResultFavoritePlacesAction>(resultFavoritePlacesReducer),

  TypedReducer<AppState, LoadPlaceDetailsAction>(loadPlaceDetailsReducer),
  TypedReducer<AppState, ErrorPlaceAction>(errorPlaceReducer),
  TypedReducer<AppState, ResultPlaceDetailsAction>(resultPlaceDetailsReducer),

  TypedReducer<AppState, ResultToggleThemeAction>(toggleThemeReducer),
]);