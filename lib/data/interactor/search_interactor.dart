import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/settings_filter.dart';
import 'package:places/ui/screens/res/constants.dart' as Constants;

class SearchInteractor {
  final _searchRepository = SearchRepository();
  final StreamController<List<Place>> _listFiltredController =
      StreamController<List<Place>>.broadcast();
  final StreamController<List<String>> _listCategoriesController =
      StreamController<List<String>>.broadcast();
  RangeValues distanceRangeValue = Constants.defaultDistanceRange;

  SearchInteractor();

  Stream<List<Place>> getFiltredPlacesStream(
    SettingsFilter? settingsFilter,
  ) {
    _searchRepository
        .getFiltredPlaces(settingsFilter)
        .then(_listFiltredController.add);
    return _listFiltredController.stream;
  }

  Stream<List<String>> getCategoriesStream() {
    getCategories().then(_listCategoriesController.add);
    return _listCategoriesController.stream;
  }

  void addErrorToFiltredController(Object error) {
    _listFiltredController.addError(error);
    _listCategoriesController.addError(error);
  }

  void dispose() {
    _listFiltredController.close();
    _listCategoriesController.close();
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
