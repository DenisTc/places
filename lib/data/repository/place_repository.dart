import 'package:dio/dio.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/domain/place.dart';

class PlaceRepository {
  final List<Place> favoritePlaces = [];
  final List<Place> visitPlaces = [];
  final Dio api;

  PlaceRepository(this.api);

  Future<List<Place>> getPlaces() async {
    final response =
        await ApiClient().client.get<List<dynamic>>(ApiConstants.placeUrl);

    if (response.statusCode == 200) {
      return response.data!
          .map(
            (dynamic place) => PlaceMapper.toModel(
              PlaceDto.fromJson(place as Map<String, dynamic>),
            ),
          )
          .toList();
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> addNewPlace(Place place) async {
    final data = place;

    final response =
        await api.post<Map<String, dynamic>>(ApiConstants.placeUrl, data: data);

    if (response.statusCode == 200) {
      return PlaceMapper.toModel(PlaceDto.fromJson(response.data!));
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> getPlaceDetails({required int id}) async {
    final response =
        await api.get<Map<String, dynamic>>('${ApiConstants.placeUrl}/$id');

    if (response.statusCode == 200) {
      return PlaceMapper.toModel(PlaceDto.fromJson(response.data!));
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> deletePlace(int id) async {
    final response = await api.delete<Place>('${ApiConstants.placeUrl}/$id');

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> putPlace(int id) async {
    final response = await api.put<Place>('${ApiConstants.placeUrl}/$id');

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<List<Place>> getFavoritesPlaces() async {
    return favoritePlaces;
  }

  Future<void> addToFavorites(Place place) async {
    favoritePlaces.add(place);
  }

  Future<void> removeFromFavorites(Place place) async {
    favoritePlaces.removeWhere((item) => item.id == place.id);
  }

  Future<bool> isFavoritePlace(Place place) async {
    return favoritePlaces.where((element) => element.id == place.id).isNotEmpty;
  }

  Future<List<Place>> getVisitPlaces() async {
    final response = getPlaces();
    return response;
  }

  Future<void> removeFromVisit(Place place) async {
    favoritePlaces.remove(place);
  }
}
