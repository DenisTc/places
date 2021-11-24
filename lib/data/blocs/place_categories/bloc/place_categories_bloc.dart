import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/domain/place.dart';

part 'place_categories_event.dart';
part 'place_categories_state.dart';

class PlaceCategoriesBloc extends Bloc<PlaceCategoriesEvent, PlaceCategoriesState> {
  final SearchRepository searchRepository;
  int countOfFilteredPlaces = 0;
  List<String> listOfSelectedCategories = [];
  PlaceCategoriesBloc(this.searchRepository) : super(PlaceCategoriesInitial());

  @override
  Stream<PlaceCategoriesState> mapEventToState(
    PlaceCategoriesEvent event,
  ) async* {
    yield PlaceCategoriesLoading();

    if (event is LoadPlaceCategories) {
      try {
        var res = await getCategories();

        if (res is List<String>) {
          yield PlaceCategoriesLoaded(res);
        } else {
          yield PlaceCategoriesError(res.toString());
        }
      } catch (e) {
        yield PlaceCategoriesError(e.toString());
      }
    }
  }

  Future<List<String>> getCategories() async {
    final _placesList = await searchRepository.getCategories();
    final _categoryList = <String>[];

    for (final place in _placesList) {
      if (!_categoryList.contains(place.placeType)) {
        _categoryList.add(place.placeType);
      }
    }
    return _categoryList;
  }

}


