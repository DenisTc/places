import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/search_filter.dart';
import 'package:places/services/location_service.dart';
import 'package:rxdart/rxdart.dart';

part 'filtered_places_event.dart';
part 'filtered_places_state.dart';

class FilteredPlacesBloc
    extends Bloc<FilteredPlacesEvent, FilteredPlacesState> {
  final SearchInteractor _searchInteractor;
  final SharedStorage _storage = SharedStorage();

  FilteredPlacesBloc(this._searchInteractor)
      : super(LoadFilteredPlacesInProgress()) {
    on<LoadFilteredPlaces>(_loadFilteredPlaces);

    on<LoadPlaceCategoriesEvent>(
      (event, emit) => _loadPlaceCategories(emit),
    );
  }

  EventTransformer<GetProductosEvent> debounce<GetProductosEvent>(
    Duration duration,
  ) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  // Get the list of filtered places
  Future<void> _loadFilteredPlaces(
    LoadFilteredPlaces event,
    Emitter<FilteredPlacesState> emit,
  ) async {
    try {
      var _filter = await _storage.getSavedSearchFilter();
      final userPosition = await LocationService.getLastKnownUserPosition();
      _filter
        ..lat = userPosition.latitude
        ..lng = userPosition.longitude
        ..distance = _filter.distance ?? const RangeValues(0.0, 10000.0);

      if (event.defaultGeo) {
        _filter = SearchFilter(typeFilter: []);
      }

      await _storage.setSearchFilter(_filter);

      final _filteredPlaces = await _searchInteractor.getFiltredPlaces(_filter);

      emit(LoadFilteredPlacesSuccess(_filteredPlaces));
    } on Exception catch (e) {
      emit(LoadFilteredPlacesError(e.toString()));
    }
  }

  // Get the list of categories
  Future<void> _loadPlaceCategories(
    Emitter<FilteredPlacesState> emit,
  ) async {
    try {
      final allCategories = await _searchInteractor.getCategories();

      emit(PlaceCategoriesLoaded(categories: allCategories));
    } on Exception catch (e) {
      emit(LoadPlaceCategoriesError(e.toString()));
    }
  }
}
