import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/settings_filter.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;


import 'filtered_places_event.dart';
import 'filtered_places_state.dart';

class FilteredPlacesBloc
    extends Bloc<FilteredPlacesEvent, FilteredPlacesState> {
  final SearchRepository _searchRepository;
  int countOfFilteredPlaces = 0;
  List<String> listOfSelectedCategories = [];
  RangeValues _distanceRangeValue = constants.defaultDistanceRange;

  FilteredPlacesBloc(this._searchRepository)
      : super(FilteredPlacesLoadInProgress());

  @override
  Stream<FilteredPlacesState> mapEventToState(
    FilteredPlacesEvent event,
  ) async* {
    try {
      if (event is FilteredPlacesLoad) {
        yield* _filteredPlacesLoadToState();
      }

      // if (event is GetCountOfFilteredPlaces) {
      //   yield CountChenging(countOfFilteredPlaces);
      // }

      

      if (event is ToggleCategory) {
        yield FilteredPlacesLoadInProgress();
        if (listOfSelectedCategories.contains(event.name)) {
          listOfSelectedCategories.remove(event.name);
        } else {
          listOfSelectedCategories.add(event.name);
        }

        SettingsFilter filter = SettingsFilter(lat: constants.userLocation.lat, lng: constants.userLocation.lng, distance: _distanceRangeValue, typeFilter: listOfSelectedCategories);
        List<Place> plac = await _searchRepository.getFiltredPlaces(filter);
        countOfFilteredPlaces = plac.length;

        // yield CountChenging(countOfFilteredPlaces);
        yield SelectedCategoryLoaded(categories: listOfSelectedCategories, count: countOfFilteredPlaces); // CategorySelected
        // await CountChenging(countOfFilteredPlaces);
        // yield CountChenging(countOfFilteredPlaces);
      }


      if(event is GetRangeValues){
        // SettingsFilter filter = SettingsFilter(lat: constants.userLocation.lat, lng: constants.userLocation.lng, distance: event.rangeValues, typeFilter: listOfSelectedCategories);
        // List<Place> plac = await _searchRepository.getFiltredPlaces(filter);
        // countOfFilteredPlaces = plac.length;
        // yield SelectedCategoryLoaded(categories: listOfSelectedCategories, count: countOfFilteredPlaces);

        yield RangeValuesLoaded(_distanceRangeValue);
      }

      if(event is SetRangeValues){
        _distanceRangeValue = event.rangeValues;
   


        yield RangeValuesLoaded(_distanceRangeValue);

        SettingsFilter filter = SettingsFilter(lat: constants.userLocation.lat, lng: constants.userLocation.lng, distance: _distanceRangeValue, typeFilter: listOfSelectedCategories);
        List<Place> plac = await _searchRepository.getFiltredPlaces(filter);
        countOfFilteredPlaces = plac.length;
        yield SelectedCategoryLoaded(categories: listOfSelectedCategories, count: countOfFilteredPlaces);
      }

    } catch (e) {
      yield FilteredPlacesLoadError(e.toString());
    }
  }

  Stream<FilteredPlacesState> _filteredPlacesLoadToState({SettingsFilter? filters = null}) async* {
    try {
      final filteredPlaces =
          await _searchRepository.getFiltredPlaces(filters ?? SettingsFilter());

      yield FilteredPlacesLoadSuccess(filteredPlaces);
    } catch (e) {
      yield FilteredPlacesLoadError(e.toString());
    }
  }
}
