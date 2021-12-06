import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/settings_filter.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:rxdart/rxdart.dart';

import 'filtered_places_event.dart';
import 'filtered_places_state.dart';

class FilteredPlacesBloc
    extends Bloc<FilteredPlacesEvent, FilteredPlacesState> {
  final SearchRepository _searchRepository;
  SettingsFilter placeFilter = SettingsFilter(
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

  FilteredPlacesBloc(this._searchRepository)
      : super(LoadFilteredPlacesInProgress()) {
    on<LoadFilteredPlaces>(
      (event, emit) => _loadFilteredPlaces(event, emit, placeFilter),
    );

    on<LoadPlaceCategories>(
      (event, emit) => _loadPlaceCategories(event, emit),
    );

    on<LoadFilterParameters>(
      (event, emit) => _loadFilterParameters(event, emit),
    );

    on<ToggleCategory>(
      (event, emit) => _toggleCategory(event, emit),
    );

    on<UpdateDistance>(
      (event, emit) => _updateDistance(event, emit),
      transformer: debounce(Duration(milliseconds: 500)),
    );

    on<ClearFilter>(
      (event, emit) => _clearFilter(event, emit),
    );
  }

  //TODO: refactoring
  void _loadFilteredPlaces(
      LoadFilteredPlaces event, Emitter<FilteredPlacesState> emit,
      [SettingsFilter? filters = null]) async {
    try {
      final filteredPlaces = await _searchRepository.getFiltredPlaces(
        event.filters ??
            SettingsFilter(
              lat: constants.userLocation.lat,
              lng: constants.userLocation.lng,
              distance: constants.defaultDistanceRange,
              typeFilter: ['other', 'monument'],
            ),
      );

      emit(LoadFilteredPlacesSuccess(filteredPlaces));
    } catch (e) {
      emit(LoadFilteredPlacesError(e.toString()));
    }
  }

  void _loadPlaceCategories(
      LoadPlaceCategories event, Emitter<FilteredPlacesState> emit) async {
    try {
      var allCategories = await getCategories();

      emit(
        PlaceCategoriesLoaded(
          categories: allCategories,
          selectedCategories: placeFilter.typeFilter!,
        ),
      );
    } catch (e) {
      emit(LoadPlaceCategoriesError(e.toString()));
    }
  }

  void _loadFilterParameters(
      LoadFilterParameters event, Emitter<FilteredPlacesState> emit) async {
    final filteredPlaces =
        await _searchRepository.getFiltredPlaces(placeFilter);
    emit(
      LoadFilterSuccess(
        count: filteredPlaces.length,
        placeFilter: placeFilter,
      ),
    );
  }

  void _toggleCategory(
      ToggleCategory event, Emitter<FilteredPlacesState> emit) async {
    if (placeFilter.typeFilter!.contains(event.name)) {
      placeFilter.typeFilter!.remove(event.name);
    } else {
      placeFilter.typeFilter!.add(event.name);
    }

    final filteredPlaces =
        await _searchRepository.getFiltredPlaces(placeFilter);

    emit(
      CategoryToggled(placeFilter.typeFilter!),
    );

    emit(
      LoadFilterSuccess(
        count: filteredPlaces.length,
        placeFilter: placeFilter,
      ),
    );
  }

  void _updateDistance(
      UpdateDistance event, Emitter<FilteredPlacesState> emit) async {
    placeFilter.distance = event.distance;
    final filteredPlaces =
        await _searchRepository.getFiltredPlaces(placeFilter);

    emit(
      LoadFilterSuccess(count: filteredPlaces.length, placeFilter: placeFilter),
    );
  }

  void _clearFilter(
      ClearFilter event, Emitter<FilteredPlacesState> emit) async {
    emit(ClearSlider(constants.defaultDistanceRange));

    placeFilter = SettingsFilter(
      lat: constants.userLocation.lat,
      lng: constants.userLocation.lng,
      distance: constants.defaultDistanceRange,
      typeFilter: [],
    );

    final filteredPlaces =
        await _searchRepository.getFiltredPlaces(placeFilter);

    emit(LoadFilterSuccess(
        count: filteredPlaces.length, placeFilter: placeFilter));
  }

  Future<List<String>> getCategories() async {
    final _placesList = await _searchRepository.getCategories();
    final _categoryList = <String>[];

    for (final place in _placesList) {
      if (!_categoryList.contains(place.placeType)) {
        _categoryList.add(place.placeType);
      }
    }
    return _categoryList;
  }
}
