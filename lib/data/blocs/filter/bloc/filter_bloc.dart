import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/domain/search_filter.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:rxdart/rxdart.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final SearchInteractor _searchInteractor;
  final SharedStorage _storage = SharedStorage();
  SearchFilter? _currentFilter;

  FilterBloc(this._searchInteractor) : super(FilterInitial()) {
    on<LoadFilterEvent>(
      (event, emit) => _loadFilter(event, emit),
    );

    on<ToggleCategoryEvent>(
      (event, emit) => _toggleCategory(event, emit),
    );

    on<UpdateFilterDistanceEvent>(
      (event, emit) => _updateDistance(event, emit),
      transformer: debounce(
        Duration(milliseconds: 500),
      ),
    );

    on<SaveFilterEvent>(
      (event, emit) => _saveFilter(),
    );

    on<ClearFilterEvent>(
      (event, emit) => _clearFilter(event, emit),
    );
  }

  EventTransformer<GetProductosEvent> debounce<GetProductosEvent>(
    Duration duration,
  ) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _loadFilter(
    LoadFilterEvent event,
    Emitter<FilterState> emit,
  ) async {
    try {
      // Return categories
      final allCategories = await _searchInteractor.getCategories();
      emit(LoadFilterCategoriesSuccess(allCategories));

      // Get filter
      final _filters = await _storage.getSavedSearchFilter();
      if (_filters.lat != null) {
        _currentFilter = _filters;
      } else {
        _currentFilter = SearchFilter();
      }

      emit(LoadFiltersSuccess(_filters));

      // Return count filtered places
      final filteredPlaces = await _searchInteractor.getFiltredPlaces(_filters);
      emit(LoadCountFilteredPlacesSuccess(filteredPlaces.length));
    } on Exception catch (e) {
      emit(LoadFiltersError(e.toString()));
    }
  }

  Future<void> _clearFilter(
    ClearFilterEvent event,
    Emitter<FilterState> emit,
  ) async {
    _currentFilter = SearchFilter(typeFilter: []);

    emit(LoadFiltersSuccess(_currentFilter!));

    final filteredPlaces =
        await _searchInteractor.getFiltredPlaces(_currentFilter!);

    emit(LoadCountFilteredPlacesSuccess(filteredPlaces.length));
  }

  Future<void> _toggleCategory(
    ToggleCategoryEvent event,
    Emitter<FilterState> emit,
  ) async {
    if (_currentFilter?.lat == null) {
      _currentFilter = await _storage.getSearchFilter();
    }

    if (_currentFilter!.typeFilter != null &&
        _currentFilter!.typeFilter!.contains(event.name)) {
      _currentFilter!.typeFilter!.remove(event.name);
    } else {
      _currentFilter!.typeFilter?.add(event.name);
    }

    emit(LoadFiltersSuccess(_currentFilter!));

    final filteredPlaces =
        await _searchInteractor.getFiltredPlaces(_currentFilter!);

    emit(LoadCountFilteredPlacesSuccess(filteredPlaces.length));
  }

  Future<void> _updateDistance(
    UpdateFilterDistanceEvent event,
    Emitter<FilterState> emit,
  ) async {
    _currentFilter!.distance = event.distance;

    final filteredPlaces =
        await _searchInteractor.getFiltredPlaces(_currentFilter!);
    emit(LoadFilterDistanceSuccess(event.distance));

    emit(LoadCountFilteredPlacesSuccess(filteredPlaces.length));
  }

  Future<void> _saveFilter() async {
    if (_currentFilter?.lat == null) {
      _storage.deleteKey(constants.keySPFilter);
    } else {
      _storage.setSearchFilter(_currentFilter!);
    }
  }
}
