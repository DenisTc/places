import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:rxdart/rxdart.dart';

import 'filtered_places_event.dart';
import 'filtered_places_state.dart';

class FilteredPlacesBloc
    extends Bloc<FilteredPlacesEvent, FilteredPlacesState> {
  final SearchInteractor _searchInteractor;
  final SharedStorage _storage = SharedStorage();

  EventTransformer<GetProductosEvent> debounce<GetProductosEvent>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  FilteredPlacesBloc(this._searchInteractor)
      : super(LoadFilteredPlacesInProgress()) {
    on<LoadFilteredPlaces>(
      (event, emit) => _loadFilteredPlaces(event, emit),
    );

    on<LoadPlaceCategoriesEvent>(
      (event, emit) => _loadPlaceCategories(event, emit),
    );
  }

  // Get the list of filtered places
  void _loadFilteredPlaces(
    LoadFilteredPlaces event,
    Emitter<FilteredPlacesState> emit,
  ) async {
    try {
      final _filter = await _storage.getSearchFilter();

      final _filteredPlaces = await _searchInteractor.getFiltredPlaces(_filter);

      emit(LoadFilteredPlacesSuccess(_filteredPlaces));
    } catch (e) {
      emit(LoadFilteredPlacesError(e.toString()));
    }
  }

  // Get the list of categories
  void _loadPlaceCategories(
    LoadPlaceCategoriesEvent event,
    Emitter<FilteredPlacesState> emit,
  ) async {
    try {
      var allCategories = await _searchInteractor.getCategories();

      emit(PlaceCategoriesLoaded(categories: allCategories));
    } catch (e) {
      emit(LoadPlaceCategoriesError(e.toString()));
    }
  }
}
