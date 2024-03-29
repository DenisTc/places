import 'dart:async';

import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/search_filter.dart';

class SearchInteractor {
  final SearchRepository _searchRepository;

  SearchInteractor(this._searchRepository);

  // Get a list of filtered places
  Future<List<Place>> getFiltredPlaces(SearchFilter? filter) async =>
      _searchRepository.getFiltredPlaces(filter);

  // Get a list of all categories
  Future<List<String>> getCategories() async {
    // Get a list of all places
    final _placesList =
        await _searchRepository.getFiltredPlaces(SearchFilter());

    final _categoryList = <String>[];

    // Get a list with unique category values from the list of all places
    for (final place in _placesList) {
      if (!_categoryList.contains(place.placeType)) {
        _categoryList.add(place.placeType);
      }
    }

    return _categoryList;
  }
}
