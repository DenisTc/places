import 'package:flutter/material.dart';
import 'package:places/data/extensions/debouncer.dart';
import 'package:places/data/redux/action/filter_action.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/filters.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/domain/search_filter.dart';
import 'package:redux/redux.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;

class FilterMiddleware implements MiddlewareClass<AppState> {
  final SearchRepository _searchRepository;
  SearchFilter newFilter = SearchFilter(
    lat: constants.userLocation.lat,
    lng: constants.userLocation.lng,
    distance: constants.defaultDistanceRange,
    typeFilter: ['other', 'monument'],
  );
  int count = 0;
  FilterMiddleware(this._searchRepository);
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is ClearFilterAction) {
      newFilter.typeFilter = [];
      newFilter.distance = constants.defaultDistanceRange;
      count = (await _searchRepository.getFiltredPlaces(newFilter)).length;
      debugPrint('count ' + count.toString());
      return store.dispatch(ResultFilterAction(newFilter, count));
    }

    if (action is ToggleCategoryAction) {
      if (newFilter.typeFilter == null) {
        newFilter.typeFilter = [];
        newFilter.lat = constants.userLocation.lat;
        newFilter.lng = constants.userLocation.lng;
        newFilter.distance = constants.defaultDistanceRange;
      }

      if (newFilter.typeFilter!.contains(action.type)) {
        newFilter.typeFilter!.remove(action.type);
      } else {
        newFilter.typeFilter!.add(action.type);
      }

      count = (await _searchRepository.getFiltredPlaces(newFilter)).length;

      return store.dispatch(ResultFilterAction(newFilter, count));
    }

    if (action is LoadFilterAction) {
      return store.dispatch(ResultFilterAction(newFilter, count));
    }

    if (action is ChangeDistanceFilterAction) {
      newFilter.distance = action.value;

      if (newFilter.typeFilter != null)
        _debouncer.call(() async {
          count = (await _searchRepository.getFiltredPlaces(newFilter)).length;
          return store.dispatch(ResultFilterAction(newFilter, count));
        });
    }

    if (action is LoadCountFilteredPlacesAction) {
      count = (await _searchRepository.getFiltredPlaces(newFilter)).length;
      return store.dispatch(ResultFilterAction(newFilter, count));
    }

    if (action is UpdateFilterAction) {
      Filters.filter = newFilter;
    }

    next(action);
  }
}
