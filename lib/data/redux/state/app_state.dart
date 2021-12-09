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

  AppState({
    required this.filteredPlacesState,
    required this.favoritePlacesState,
    required this.placeState,
    required this.themeState,
    required this.filterState,
  });

  AppState copyWith({
    filteredPlacesState,
    favoritePlacesState,
    placeState,
    themeState,
    filterState,
  }) =>
      AppState(
        filteredPlacesState: filteredPlacesState ?? this.filteredPlacesState,
        favoritePlacesState: favoritePlacesState ?? this.favoritePlacesState,
        placeState: placeState ?? this.placeState,
        themeState: themeState ?? this.themeState,
        filterState: filterState ?? this.filterState,
      );
}
