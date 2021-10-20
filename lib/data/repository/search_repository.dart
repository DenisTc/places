import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/domain/place.dart';

class SearchRepository {
  final Dio api;

  SearchRepository(this.api);

  Future<List<PlaceDto>> searchPlaces({
    double? lat,
    double? lng,
    double? radius,
    List<String>? typeFilter,
  }) async {
    final data = {
      'lat': lat,
      'lng': lng,
      'radius': radius,
      'typeFilter': typeFilter,
    };

    final response = await ApiClient()
        .client
        .post<String>(ApiConstants.filteredPlacesUrl, data: data);
    if (response.statusCode == 200) {
      final placesList = (jsonDecode(response.toString()) as List<dynamic>)
          .map(
            (dynamic place) => PlaceDto.fromJson(place as Map<String, dynamic>),
          )
          .toList();
      return placesList;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<List<Place>> searchPlacesByName({
    String? name,
  }) async {
    final data = {
      'nameFilter': name,
    };

    final response = await ApiClient()
        .client
        .post<String>(ApiConstants.filteredPlacesUrl, data: data);
    if (response.statusCode == 200) {
      final placesList = (jsonDecode(response.toString()) as List<dynamic>)
          .map((dynamic place) => PlaceMapper.toModel(
              PlaceDto.fromJson(place as Map<String, dynamic>)))
          .toList();
      return placesList;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }
}
