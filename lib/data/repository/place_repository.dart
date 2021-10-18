import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/domain/place.dart';

class PlaceRepository {
  static List<Place> favoritePlaces = [];
  static List<Place> visitPlaces = [];

  static Future<Place?> addToFavorites(Place place) async {
    favoritePlaces.add(place);
  }

  Future<List<Place>> getVisitPlaces() async {
    final response = getPlaces();
    return response;
  }

  Future<List<Place>> getPlaces() async {
    final response = await ApiClient().client.get<List<dynamic>>(ApiConstants.placeUrl);

    if (response.statusCode == 200) {
      return response.data!
          .map((dynamic place) => PlaceDto.fromJson(place as Map<String, dynamic>).toModel())
          .toList();
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> addNewPlace(Place place) async {
    final data = place;

    final response = await ApiClient().client.post<Map<String, dynamic>>(ApiConstants.placeUrl, data: data);

    if (response.statusCode == 200) {
      return PlaceDto.fromJson(response.data!).toModel();
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> getPlaceDetails({required int id}) async {
    final response = await ApiClient().client.get<Map<String, dynamic>>('${ApiConstants.placeUrl}/$id');

    if (response.statusCode == 200) {
      return PlaceDto.fromJson(response.data!).toModel();
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> deletePlace(int id) async {
    final response = await ApiClient().client.delete<Place>('${ApiConstants.placeUrl}/$id');

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> putPlace(int id) async {
    final response = await ApiClient().client.put<Place>('${ApiConstants.placeUrl}/$id');

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<List<Place>> getFavoritesPlaces() async {
    final response = favoritePlaces;

    return response;
  }

  Future<void> removeFromFavorites(Place place) async {
    favoritePlaces.remove(place);
  }

  Future<void> removeFromVisit(Place place) async {
    favoritePlaces.remove(place);
  }
}