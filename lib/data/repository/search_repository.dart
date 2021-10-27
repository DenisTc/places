import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/domain/place.dart';

class SearchRepository {
  final Dio api;

  SearchRepository(this.api);

  Future<List<Place>> searchPlaces({
    double? lat,
    double? lng,
    RangeValues? distance,
    List<String>? typeFilter,
    String? nameFilter,
  }) async {
    final data = {
      'lat': lat,
      'lng': lng,
      'radius': distance?.end,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
    };

    final response = await ApiClient().client.post<String>(
          ApiConstants.filteredPlacesUrl,
          data: data,
        );

    var placeDtoList = (jsonDecode(response.toString()) as List<dynamic>)
        .map(
          (dynamic place) => PlaceDto.fromJson(place as Map<String, dynamic>),
        )
        .toList();

    if (distance != null) {
      placeDtoList = placeDtoList
          .where((place) => place.distance! >= distance.start)
          .toList();
    }

    final placesList = placeDtoList
        .map((dynamic place) => PlaceMapper.toModel(place as PlaceDto))
        .toList();

    return placesList;
  }
}
