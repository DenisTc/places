import 'package:flutter/material.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/place.dart';

SearchRepository _searchRepository = SearchRepository();

class SearchInteractor {
  Future<List<Place>> searchPlaces({
    required double lat,
    required double lng,
    required RangeValues distance,
    List<String>? typeFilter,
  }) async {
    final placesList = await _searchRepository.searchPlaces(
      lat: lat,
      lng: lng,
      radius: distance.end,
      typeFilter: typeFilter,
    );

    final _filredPlaces = <Place>[];

    for (final place in placesList) {
      if (place.distance! >= distance.start) {
        _filredPlaces.add(place.toModel());
      }
    }

    return _filredPlaces;
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
