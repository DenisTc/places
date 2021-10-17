import 'dart:convert';

import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';

class SearchRepository {
  Future<List<PlaceDto>> searchPlaces({
    double? lat,
    double? lng,
    double? radius,
    List<String>? typeFilter,
    String? nameFilter,
  }) async {
    final data = {
      'lat': lat,
      'lng': lng,
      'radius': radius,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
    };

    final response = await ApiClient()
        .client
        .post<String>(ApiConstants.filteredPlacesUrl, data: data);
    if (response.statusCode == 200) {
      final placesList = (jsonDecode(response.toString()) as List<dynamic>)
          .map((dynamic place) =>
              PlaceDto.fromJson(place as Map<String, dynamic>))
          .toList();
      return placesList;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }
}
