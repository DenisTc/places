import 'package:places/data/redux/state/favorite_places_state.dart';
import 'package:places/data/redux/state/filtered_places_state.dart';

class AppState {
  final FilteredPlacesState filteredPlacesState;
  final FavoritePlacesState favoritePlacesState;

  AppState({
    required this.filteredPlacesState,
    required this.favoritePlacesState,
  });

  AppState copyWith({
    filteredPlacesState,
    favoritePlacesState,
  }) =>
      AppState(
        filteredPlacesState: filteredPlacesState ?? this.filteredPlacesState,
        favoritePlacesState: favoritePlacesState ?? this.favoritePlacesState,
      );
}
