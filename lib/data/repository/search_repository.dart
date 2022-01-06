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

  // Getting a list of places by the specified filter
  Future<List<Place>> getFiltredPlaces(SearchFilter? settingsFilter) async {
    final data = settingsFilter!.toMap();

    // Get data(json) from remote repository
    final response = await api.client.post<String>(
      ApiConstants.filteredPlacesUrl,
      data: data,
    );

    // Convert json to List<PlaceDto>
    var placeDtoList = (jsonDecode(response.toString()) as List<dynamic>)
        .map(
          (dynamic place) => PlaceDto.fromJson(place as Map<String, dynamic>),
        )
        .toList();

    // Filtering the list by radius (distance) 
    if (settingsFilter.distance != null) {
      placeDtoList = placeDtoList
          .where((place) =>
              place.distance! >= (settingsFilter.distance as RangeValues).start)
          .toList();
    }

    // Convert List<PlaceDto> to List<Place>
    final placesList = placeDtoList
        .map((dynamic place) => PlaceMapper.toModel(place as PlaceDto))
        .toList();

    return placesList;
  }
}
