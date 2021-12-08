import 'package:places/data/redux/state/favorite_places_state.dart';
import 'package:places/data/redux/state/filtered_places_state.dart';
import 'package:places/data/redux/state/place_state.dart';

class AppState {
  final FilteredPlacesState filteredPlacesState;
  final FavoritePlacesState favoritePlacesState;
  final PlaceState placeState;

  AppState({
    required this.filteredPlacesState,
    required this.favoritePlacesState,
    required this.placeState,
  });

  AppState copyWith({
    filteredPlacesState,
    favoritePlacesState,
    placeState,
  }) =>
      AppState(
        filteredPlacesState: filteredPlacesState ?? this.filteredPlacesState,
        favoritePlacesState: favoritePlacesState ?? this.favoritePlacesState,
        placeState: placeState ?? this.placeState,
      );
}
