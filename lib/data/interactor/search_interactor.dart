import 'package:flutter/material.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/search_repository.dart';

SearchRepository _searchRepository = SearchRepository();

class SearchInteractor {
  Future<List<PlaceDto>> searchPlaces({
    String name = '',
    double? lat,
    double? lng,
    double? radius,
    List<String>? typeFilter,
  }) async {
    return _searchRepository.searchPlaces(
      lat: lat,
      lng: lng,
      radius: radius,
      typeFilter: typeFilter,
      nameFilter: name,
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
