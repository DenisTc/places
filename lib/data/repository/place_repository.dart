import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/domain/place.dart';

class PlaceRepository {
  final ApiClient api;
  final List<Place> favoritePlaces = [];
  final Map<Place, DateTime> visitPlaces = {};

  PlaceRepository(this.api);

  // Getting a list of all places
  Future<List<Place>> getPlaces() async {
    final response = await api.client.get<List<dynamic>>(ApiConstants.placeUrl);

    return response.data!
        .map(
          (dynamic place) => PlaceMapper.toModel(
            PlaceDto.fromJson(place as Map<String, dynamic>),
          ),
        )
        .toList();
  }

  // Get a detailed description of the place
  Future<Place> getPlaceDetails({required int id}) async {
    final response = await api.client
        .get<Map<String, dynamic>>('${ApiConstants.placeUrl}/$id');

    return PlaceMapper.toModel(PlaceDto.fromJson(response.data!));
  }

  // Sending information about the new place to a remote server
  Future<dynamic> addNewPlace(Place place) async {
    final data = place.toJson();
    final response = await api.client.post(ApiConstants.placeUrl, data: data);

    return response;
  }

  // Checking for a place on the list of favorite places
  bool isFavoritePlace(Place place) {
    final isFavorite = favoritePlaces.any((item) => item.id == place.id);
    return isFavorite;
  }

  // Add or remove a place from the list of favorite places
  Future<void> toggleToFavorites(Place place) async {
    bool isContain = isFavoritePlace(place);

    if (isContain) {
      favoritePlaces.remove(place);
    } else {
      favoritePlaces.add(place);
    }
  }

  // Upload image on remote server
  Future<String> uploadImage(String image) async {
    String mimeType = mime(image)!;
    String type = mimeType.split('/')[0];
    String subtype = mimeType.split('/')[1];
    String fileName = image.split('/').last;

    FormData formData = FormData.fromMap(
      {
        "image": [
          await MultipartFile.fromFile(
            image,
            filename: fileName,
            contentType: MediaType(type, subtype),
          ),
        ],
      },
    );

    final response =
        await api.client.post(ApiConstants.uploadFile, data: formData);

    return '${ApiConstants.baseUrl}/${response.headers['location']!.first}';
  }
}
