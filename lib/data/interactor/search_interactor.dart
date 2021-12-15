import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/search_filter.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;

class SearchInteractor {
  final SearchRepository _searchRepository;

  final StreamController<List<Place>> _listFiltredController =
      StreamController<List<Place>>.broadcast();
  final StreamController<List<String>> _listCategoriesController =
      StreamController<List<String>>.broadcast();
  List<String> selectedFilters = [];
  RangeValues get getRangeValue => _distanceRangeValue;
  RangeValues _distanceRangeValue = constants.defaultDistanceRange;

  SearchInteractor(this._searchRepository);

  void setRangeValue(RangeValues rangeValues) {
    _distanceRangeValue = rangeValues;
    // notifyListeners();
  }

  void selectCategory(String category) {
    if (selectedFilters.contains(category.toLowerCase())) {
      selectedFilters.remove(category.toLowerCase());
    } else {
      selectedFilters.add(category.toLowerCase());
    }
    // notifyListeners();
  }

  Stream<List<Place>> getFiltredPlacesStream(SearchFilter? settingsFilter) {
    _searchRepository
        .getFiltredPlaces(settingsFilter)
        .then(_listFiltredController.add)
        .onError(
      (error, stackTrace) {
        addErrorToFiltredController(error!);
      },
    );
    return _listFiltredController.stream;
  }

  Stream<List<String>> getCategoriesStream() {
    getCategories().then(_listCategoriesController.add).onError(
      (error, stackTrace) {
        addErrorToFiltredController(error!);
      },
    );
    return _listCategoriesController.stream;
  }

  void addErrorToFiltredController(Object error) {
    _listFiltredController.addError(error);
    _listCategoriesController.addError(error);
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
