import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/search_filter.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:rxdart/rxdart.dart';

import 'filtered_places_event.dart';
import 'filtered_places_state.dart';

class FilteredPlacesBloc
    extends Bloc<FilteredPlacesEvent, FilteredPlacesState> {
  final SearchInteractor _searchInteractor;

  SearchFilter temporaryFilter = SearchFilter(
    lat: constants.userLocation.lat,
    lng: constants.userLocation.lng,
    distance: constants.defaultDistanceRange,
    typeFilter: ['other', 'monument'],
  );
  SearchFilter searchFilter = SearchFilter(
    lat: constants.userLocation.lat,
    lng: constants.userLocation.lng,
    distance: constants.defaultDistanceRange,
    typeFilter: ['other', 'monument'],
  );

  List<Place> filtredPlaces = [];

  EventTransformer<GetProductosEvent> debounce<GetProductosEvent>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  FilteredPlacesBloc(this._searchInteractor)
      : super(LoadFilteredPlacesInProgress()) {
    on<LoadFilteredPlaces>(
      (event, emit) => _loadFilteredPlaces(event, emit, temporaryFilter),
    );

    on<LoadPlaceCategoriesEvent>(
      (event, emit) => _loadPlaceCategories(event, emit),
    );

    on<LoadFilterParamsEvent>(
      (event, emit) => _loadFilterParameters(event, emit),
    );

    on<ToggleCategoryEvent>(
      (event, emit) => _toggleCategory(event, emit),
    );

    on<UpdateDistanceEvent>(
      (event, emit) => _updateDistance(event, emit),
      transformer: debounce(Duration(milliseconds: 500)),
    );

    on<ClearFilterEvent>(
      (event, emit) => _clearFilter(event, emit),
    );

    on<SaveSearchFilterEvent>((event, emit) => searchFilter = temporaryFilter);
  }

  void _loadFilteredPlaces(
      LoadFilteredPlaces event, Emitter<FilteredPlacesState> emit,
      [SearchFilter? filters = null]) async {
    try {
      final filteredPlaces =
          await _searchInteractor.getFiltredPlaces(searchFilter);

      emit(LoadFilteredPlacesSuccess(filteredPlaces));
    } catch (e) {
      emit(LoadFilteredPlacesError(e.toString()));
    }
  }

  void _loadPlaceCategories(
      LoadPlaceCategoriesEvent event, Emitter<FilteredPlacesState> emit) async {
    try {
      var allCategories = await getCategories();

      emit(
        PlaceCategoriesLoaded(
          categories: allCategories,
          selectedCategories: temporaryFilter.typeFilter!,
        ),
      );
    } catch (e) {
      emit(LoadPlaceCategoriesError(e.toString()));
    }
  }

  void _loadFilterParameters(
      LoadFilterParamsEvent event, Emitter<FilteredPlacesState> emit) async {
    final filteredPlaces =
        await _searchInteractor.getFiltredPlaces(temporaryFilter);
    emit(
      LoadFilterSuccess(
        count: filteredPlaces.length,
        placeFilter: temporaryFilter,
      ),
    );
  }

  void _toggleCategory(
      ToggleCategoryEvent event, Emitter<FilteredPlacesState> emit) async {
    if (temporaryFilter.typeFilter!.contains(event.name)) {
      temporaryFilter.typeFilter!.remove(event.name);
    } else {
      temporaryFilter.typeFilter!.add(event.name);
    }

    final filteredPlaces =
        await _searchInteractor.getFiltredPlaces(temporaryFilter);

    emit(
      CategoryToggled(temporaryFilter.typeFilter!),
    );

    emit(
      LoadFilterSuccess(
        count: filteredPlaces.length,
        placeFilter: temporaryFilter,
      ),
    );
  }

  void _updateDistance(
      UpdateDistanceEvent event, Emitter<FilteredPlacesState> emit) async {
    temporaryFilter.distance = event.distance;
    final filteredPlaces =
        await _searchInteractor.getFiltredPlaces(temporaryFilter);

    emit(
      LoadFilterSuccess(
          count: filteredPlaces.length, placeFilter: temporaryFilter),
    );
  }

  void _clearFilter(
      ClearFilterEvent event, Emitter<FilteredPlacesState> emit) async {
    emit(ClearSlider(constants.defaultDistanceRange));
    temporaryFilter = SearchFilter(
      lat: constants.userLocation.lat,
      lng: constants.userLocation.lng,
      distance: constants.defaultDistanceRange,
      typeFilter: [],
    );

    final filteredPlaces =
        await _searchInteractor.getFiltredPlaces(temporaryFilter);

    emit(LoadFilterSuccess(
        count: filteredPlaces.length, placeFilter: temporaryFilter));
  }

  Future<List<String>> getCategories() async {
    final _categoryList = await _searchInteractor.getCategories();
    return _categoryList;
  }
}
