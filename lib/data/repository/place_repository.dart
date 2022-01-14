import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/database/database.dart';
import 'package:places/domain/place.dart';

class PlaceRepository {
  final ApiClient api;
  final LocalDatabase db;

  PlaceRepository({required this.api, required this.db});

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

  //
  Future<List<Place>> getFavoritePlaces() async {
    final favoritePlaces = await db.favoritePlacesDao.loadFavoritePlaces();
    return favoritePlaces;
  }

  // Checking for a place on the list of favorite places
  Future<bool> isFavoritePlace(Place place) async {
    final isFavorite =
        await db.favoritePlacesDao.isFavoritePlaceExist(place.id!);
    return isFavorite;
  }

  // Add place to list of favorite places
  Future<void> addPlaceToFavorites(Place place) async {
    db.favoritePlacesDao.addPlaceToFavorites(place.id!);
  }

  // Add place from list of favorite places
  Future<void> deletePlaceFromFavorites(Place place) async {
    db.favoritePlacesDao.deletePlaceFromFavorites(place.id!);
  }

  // Add place to device cache
  Future<void> addPlaceToCache(Place place) async {
    db.cachedPlacesDao.addPlaceToCache(place);
  }

  // Delete place from device cache
  Future<void> deletePlaceFromCache(Place place) async {
    db.cachedPlacesDao.deletePlaceFromCache(place.id!);
  }

  Future<List<Place?>> loadFavoritePlaces() async {
    final favoritePlaces = await db.favoritePlacesDao.loadFavoritePlaces();
    return favoritePlaces;
  }

  // Get a list of cached places on the device
  Future<List<Place>> loadCachedPlaces() async {
    final cachedPlaces = db.cachedPlacesDao.getAllCachedPlaces();
    print(cachedPlaces);
    return [];
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
