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
    typeFilter: [],
  );
  List<Place> filtredPlaces = [];

  FilteredPlacesBloc(this._searchRepository)
      : super(LoadFilteredPlacesInProgress());

  @override
  Stream<Transition<FilteredPlacesEvent, FilteredPlacesState>> transformEvents(
      Stream<FilteredPlacesEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) => event is! UpdateDistance);

    final debounceStream = events
        .where((event) => event is UpdateDistance)
        .debounceTime(const Duration(milliseconds: 500));

    return super.transformEvents(
        MergeStream([nonDebounceStream, debounceStream]), transitionFn);
  }

  @override
  Stream<FilteredPlacesState> mapEventToState(
    FilteredPlacesEvent event,
  ) async* {
    try {
      if (event is LoadFilteredPlaces) {
        yield* _mapFilteredPlacesLoadToState(event.filters);
      }

      if (event is LoadFilter) {
        final filteredPlaces =
            await _searchRepository.getFiltredPlaces(placeFilter);
        yield LoadFilterSuccess(
            count: filteredPlaces.length, placeFilter: placeFilter);
      }

      if (event is ToggleCategory) {
        if (placeFilter.typeFilter!.contains(event.name)) {
          placeFilter.typeFilter!.remove(event.name);
        } else {
          placeFilter.typeFilter!.add(event.name);
        }

        final filteredPlaces =
            await _searchRepository.getFiltredPlaces(placeFilter);
        yield CategoryToggled(placeFilter.typeFilter!);
        yield LoadFilterSuccess(
            count: filteredPlaces.length, placeFilter: placeFilter);
      }

      if (event is UpdateDistance) {
        placeFilter.distance = event.distance;
        final filteredPlaces =
            await _searchRepository.getFiltredPlaces(placeFilter);
        yield LoadFilterSuccess(
            count: filteredPlaces.length, placeFilter: placeFilter);
      }

      if (event is ClearFilter) {
        yield ClearSlider(constants.defaultDistanceRange);

        placeFilter = SettingsFilter(
          lat: constants.userLocation.lat,
          lng: constants.userLocation.lng,
          distance: constants.defaultDistanceRange,
          typeFilter: [],
        );

        final filteredPlaces =
            await _searchRepository.getFiltredPlaces(placeFilter);

        yield LoadFilterSuccess(
            count: filteredPlaces.length, placeFilter: placeFilter);
      }

      if (event is LoadPlaceCategories) {
        try {
          var allCategories = await getCategories();

          if (allCategories is List<String>) {
            yield PlaceCategoriesLoaded(
              categories: allCategories,
              selectedCategories: placeFilter.typeFilter!,
            );
          } else {
            yield LoadPlaceCategoriesError(allCategories.toString());
          }
        } catch (e) {
          yield LoadPlaceCategoriesError(e.toString());
        }
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
