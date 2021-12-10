import 'package:places/data/redux/state/category_state.dart';
import 'package:places/data/redux/state/favorite_places_state.dart';
import 'package:places/data/redux/state/filter_state.dart';
import 'package:places/data/redux/state/filtered_places_state.dart';
import 'package:places/data/redux/state/place_state.dart';
import 'package:places/data/redux/state/theme_state.dart';

class AppState {
  final FilteredPlacesState filteredPlacesState;
  final FavoritePlacesState favoritePlacesState;
  final PlaceState placeState;
  final ThemeState themeState;
  final FilterState filterState;
  final CategoryState categoryState;

  AppState({
    required this.filteredPlacesState,
    required this.favoritePlacesState,
    required this.placeState,
    required this.themeState,
    required this.filterState,
    required this.categoryState,
  });

  AppState copyWith({
    filteredPlacesState,
    favoritePlacesState,
    placeState,
    themeState,
    filterState,
    categoryState,
  }) =>
      AppState(
        filteredPlacesState: filteredPlacesState ?? this.filteredPlacesState,
        favoritePlacesState: favoritePlacesState ?? this.favoritePlacesState,
        placeState: placeState ?? this.placeState,
        themeState: themeState ?? this.themeState,
        filterState: filterState ?? this.filterState,
        categoryState: categoryState ?? this.categoryState,
      );
}
