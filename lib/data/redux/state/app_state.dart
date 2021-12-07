import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/data/redux/state/filtered_places_state.dart';
import 'package:places/domain/place.dart';

class AppState {
  final FilteredPlacesState filteredPlacesState;

  AppState({required this.filteredPlacesState});

  AppState copyWith({
    filteredPlacesState,
  }) =>
      AppState(
        filteredPlacesState: filteredPlacesState ?? this.filteredPlacesState,
      );
}
