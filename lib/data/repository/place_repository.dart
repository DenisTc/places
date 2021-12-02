import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/domain/place.dart';

final api = ApiClient().client;

class PlaceRepository {
  final List<Place> favoritePlaces = [];
  final Map<Place, DateTime> visitPlaces = {};

  PlaceRepository();

  Future<List<Place>> getPlaces() async {
    final response = await api.get<List<dynamic>>(ApiConstants.placeUrl);

    return response.data!
        .map(
          (dynamic place) => PlaceMapper.toModel(
            PlaceDto.fromJson(place as Map<String, dynamic>),
          ),
        )
        .toList();
  }

  Future<dynamic> addNewPlace(Place place) async {
    final data = place.toJson();
    final response = await api.post(ApiConstants.placeUrl, data: data);

    return response;
  }

  Future<Place> getPlaceDetails({required int id}) async {
    final response =
        await api.get<Map<String, dynamic>>('${ApiConstants.placeUrl}/$id');

    return PlaceMapper.toModel(PlaceDto.fromJson(response.data!));
  }

  Future<Place?> deletePlace(int id) async {
    final response = await api.delete<Place>('${ApiConstants.placeUrl}/$id');
    return response.data;
  }

  Future<Place?> putPlace(int id) async {
    final response = await api.put<Place>('${ApiConstants.placeUrl}/$id');
    return response.data;
  }

  Future<List<Place>> getFavoritesPlaces() async {
    return favoritePlaces;
  }

  Future<Map<Place, DateTime>> getVisitPlaces() async {
    return visitPlaces;
  }

  bool isFavoritePlace(Place place) {
    final isFavorite = favoritePlaces.any((item) => item.id == place.id);
    return isFavorite;
  }

  bool isVisitedPlace(Place place) {
    final isVisited = visitPlaces.containsKey(place);
    return isVisited;
  }

  Future<void> toggleInFavorites(Place place) async {
    bool isContain = favoritePlaces.contains(place);

    if (isContain) {
      favoritePlaces.remove(place);
    } else {
      favoritePlaces.add(place);
    }
  }

  Future<void> removeFromVisit(Place place) async {
    favoritePlaces.remove(place);
  }

  Future<void> toggleInVisited(Place place, DateTime date) async {
    bool isContain = visitPlaces.containsKey(place);

    if (isContain) {
      visitPlaces.remove(place);
    } else {
      visitPlaces[place] = date;
    }
  }

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

    final response = await api.post(ApiConstants.uploadFile, data: formData);

    return '${ApiConstants.baseUrl}/${response.headers['location']!.first}';
  }

  Future<int> getMaxPlaceId() async {
    final listPlace = await getPlaces();

    listPlace.sort((Place place, Place nextPlace) => place.id - nextPlace.id);

    int maxId = listPlace.last.id;

    return maxId;
  }
}
