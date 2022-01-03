import 'dart:async';

import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/search_filter.dart';

class SearchInteractor {
  final SearchRepository _searchRepository;

  SearchInteractor(this._searchRepository);

  Future<List<Place>> getFiltredPlaces(SearchFilter? filter) {
    return _searchRepository.getFiltredPlaces(filter);
  }

  Future<List<String>> getCategories() async {
    final _placesList = await _searchRepository.getFiltredPlaces(SearchFilter());
    final _categoryList = <String>[];

    for (final place in _placesList) {
      if (!_categoryList.contains(place.placeType)) {
        _categoryList.add(place.placeType);
      }
    }

    return _categoryList;
  }
}
