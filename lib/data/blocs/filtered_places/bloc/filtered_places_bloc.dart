import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/settings_filter.dart';

import 'filtered_places_event.dart';
import 'filtered_places_state.dart';

class FilteredPlacesBloc
    extends Bloc<FilteredPlacesEvent, FilteredPlacesState> {
  final SearchRepository _searchRepository;

  FilteredPlacesBloc(this._searchRepository)
      : super(LoadFilteredPlacesInProgress());

  @override
  Stream<FilteredPlacesState> mapEventToState(
    FilteredPlacesEvent event,
  ) async* {
    try {
      if (event is LoadFilteredPlaces) {
        yield* _mapFilteredPlacesLoadToState(event.filters);
      }
    } catch (e) {
      yield LoadFilteredPlacesError(e.toString());
    }
  }

  Stream<FilteredPlacesState> _mapFilteredPlacesLoadToState([
    SettingsFilter? filters = null,
  ]) async* {
    try {
      final filteredPlaces = await _searchRepository.getFiltredPlaces(
        filters ?? SettingsFilter(),
      );

      yield LoadFilteredPlacesSuccess(filteredPlaces);
    } catch (e) {
      yield LoadFilteredPlacesError(e.toString());
    }
  }
}
