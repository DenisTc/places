import 'package:places/data/redux/action/favorite_places_action.dart';
import 'package:places/data/redux/action/filter_action.dart';
import 'package:places/data/redux/action/filtered_places_action.dart';
import 'package:places/data/redux/action/place_action.dart';
import 'package:places/data/redux/action/theme_action.dart';
import 'package:places/data/redux/reducer/favorite_places_reducer.dart';
import 'package:places/data/redux/reducer/filter_reducer.dart';
import 'package:places/data/redux/reducer/filtered_places_reducer.dart';
import 'package:places/data/redux/reducer/place_reducer.dart';
import 'package:places/data/redux/reducer/theme_reducer.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:redux/redux.dart';

final reducerApp = combineReducers<AppState>([
  /// Responsible for displaying a list of filtered places
  TypedReducer<AppState, LoadFilteredPlacesAction>(loadFilteredPlacesReducer),
  TypedReducer<AppState, ErrorFilteredPlacesAction>(errorFilteredPlacesReducer),
  TypedReducer<AppState, ResultFilteredPlacesAction>(resultFilteredPlacesReducer),
  
  /// Responsible for displaying the list of favorite places
  TypedReducer<AppState, LoadFavoritePlacesAction>(loadFavoritePlacesReducer),
  TypedReducer<AppState, ResultFavoritePlacesAction>(resultFavoritePlacesReducer),

  /// Responsible for displaying information about the place
  TypedReducer<AppState, LoadPlaceDetailsAction>(loadPlaceDetailsReducer),
  TypedReducer<AppState, ErrorPlaceAction>(errorPlaceReducer),
  TypedReducer<AppState, ResultPlaceDetailsAction>(resultPlaceDetailsReducer),

  /// Responsible for adding/removing categories on the filters screen
  TypedReducer<AppState, ResultToggleThemeAction>(toggleThemeReducer),

  /// Responsible for loading categories on the filter screen
  TypedReducer<AppState, LoadCategoriesAction>(loadCategoriesReducer),
  TypedReducer<AppState, ResultCategoriesAction>(resultCategoriesReducer),

  /// Responsible for loading filters to the screen 
  TypedReducer<AppState, ResultFilterAction>(resultFilterReducer),
]);