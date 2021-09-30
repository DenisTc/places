import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';

final dio = Dio(baseOptions);

BaseOptions baseOptions = BaseOptions(
  baseUrl: 'https://test-backend-flutter.surfstudio.ru',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  responseType: ResponseType.json,
);



class PlaceRepository {
  List<Place> favoritePlaces = [];
  List<Place> visitPlaces = [];
  
  Future<Places> getPlaces() async {
    final response = await dio.get<List<dynamic>>('/place');

    if (response.statusCode == 200) {
      return Places.fromJson(response.data!);
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> addNewPlace(Place place) async {
    final data = place;

    final response = await dio.post<Map<String, dynamic>>('/place', data: data);

    if (response.statusCode == 200) {
      return Place.fromJson(response.data!);
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> getPlaceDetails({required int id}) async {
    final response = await dio.get<Map<String, dynamic>>('/place/$id');

    if (response.statusCode == 200) {
      return Place.fromJson(response.data!);
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> deletePlace(int id) async {
    final response = await dio.delete<Place>('/place/$id');

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> putPlace(int id) async {
    final response = await dio.put<Place>('/place/$id');

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

    // if (response.statusCode == 200) {
    //   return Places.fromJson(response.data!);
    // }

    // throw Exception(
    //   'HTTP request error. Error code ${response.statusCode}',
    // );
  }

  Future<List<Place>> getVisitPlaces() async {
    final response = visitPlaces;

    return response;
  }
}
