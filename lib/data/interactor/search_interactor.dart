import 'package:flutter/material.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/res/constants.dart' as Constants;

class SearchInteractor {
  final SearchRepository _searchRepository;
  RangeValues distanceRangeValue = Constants.defaultDistanceRange;

  SearchInteractor(this._searchRepository);

  Future<List<Place>> searchPlaces({
    required double lat,
    required double lng,
    required RangeValues distance,
    List<String>? typeFilter,
  }) async {
    final placesList = await _searchRepository.searchPlaces(
      lat: lat,
      lng: lng,
      distance: distance,
      typeFilter: typeFilter,
    );

    return placesList;
  }

  Future<List<Place>> searchPlacesByName({
    String name = '',
  }) async {
    return _searchRepository.searchPlacesByName(
      name: name,
    );
  }

  Future<List<String>> getCategories() async {
    final _placesList = await _searchRepository.searchPlaces();
    final _categoryList = <String>[];

    for (final place in _placesList) {
      if (!_categoryList.contains(place.placeType)) {
        _categoryList.add(place.placeType);
      }
    }

    return _categoryList;
  }
}
