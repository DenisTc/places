import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/search_filter.dart';

class SearchRepository {
  final api;

  SearchRepository(this.api);

  Future<List<Place>> getFiltredPlaces(SearchFilter? settingsFilter) async {
    final data = settingsFilter!.toMap();

    final response = await api.client.post<String>(
      ApiConstants.filteredPlacesUrl,
      data: data,
    );

    var placeDtoList = (jsonDecode(response.toString()) as List<dynamic>)
        .map(
          (dynamic place) => PlaceDto.fromJson(place as Map<String, dynamic>),
        )
        .toList();

    if (settingsFilter.distance != null) {
      placeDtoList = placeDtoList
          .where((place) =>
              place.distance! >= (settingsFilter.distance as RangeValues).start)
          .toList();
    }

    final placesList = placeDtoList
        .map((dynamic place) => PlaceMapper.toModel(place as PlaceDto))
        .toList();

    return placesList;
  }

  // TODO: Удалить, переделать на интерактор
  Future<List<dynamic>> getCategories() async {
    try {
      final response = await api.client.get<dynamic>(ApiConstants.placeUrl);

      return response.data
          .map(
            (dynamic place) => PlaceMapper.toModel(
              PlaceDto.fromJson(place as Map<String, dynamic>),
            ),
          )
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // TODO: Это должно быть в place_repository.dart
  Future<List<dynamic>> getPlaces() async {
    final response = await api.client.get<dynamic>(ApiConstants.placeUrl);

    return response.data
        .map(
          (dynamic place) => PlaceMapper.toModel(
            PlaceDto.fromJson(place as Map<String, dynamic>),
          ),
        )
        .toList();
  }
}
