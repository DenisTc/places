import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/settings_filter.dart';

class SearchRepository {
  final Dio api;

  SearchRepository(this.api);

  Future<List<Place>> getFiltredPlaces(SettingsFilter? settingsFilter) async {
    final data = settingsFilter!.toMap();

    final response = await ApiClient().client.post<String>(
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

  Future<List<Place>> getCategories() async {
    final response = await api.get<List<dynamic>>(ApiConstants.placeUrl);

    return response.data!
        .map(
          (dynamic place) => PlaceMapper.toModel(
            PlaceDto.fromJson(place as Map<String, dynamic>),
          ),
        )
        .toList();
  }
}
