import 'package:dio/dio.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place.dart';

final dio = Dio(baseOptions);

BaseOptions baseOptions = BaseOptions(
  baseUrl: ApiConstants.baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  responseType: ResponseType.json,
);

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
    final response = await dio.get<List<dynamic>>(ApiConstants.placeUrl);

    if (response.statusCode == 200) {
      return response.data!
          .map((dynamic place) => Place.fromJson(place as Map<String, dynamic>))
          .toList();
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> addNewPlace(Place place) async {
    final data = place;

    final response = await dio.post<Map<String, dynamic>>(ApiConstants.placeUrl, data: data);

    if (response.statusCode == 200) {
      return Place.fromJson(response.data!);
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> getPlaceDetails({required int id}) async {
    final response = await dio.get<Map<String, dynamic>>('${ApiConstants.placeUrl}/$id');

    if (response.statusCode == 200) {
      return Place.fromJson(response.data!);
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> deletePlace(int id) async {
    final response = await dio.delete<Place>('${ApiConstants.placeUrl}/$id');

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> putPlace(int id) async {
    final response = await dio.put<Place>('${ApiConstants.placeUrl}/$id');

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