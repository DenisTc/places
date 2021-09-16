import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';

final dio = Dio(baseOptions);

BaseOptions baseOptions = BaseOptions(
  baseUrl: 'https://test-backend-flutter.surfstudio.ru',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  responseType: ResponseType.json,
);

class PlaceRepository {
  Future<Places> getListPlaces() async {
    final response = await dio.get<List<dynamic>>('/place');

    if (response.statusCode == 200) {
      return Places.fromJson(response.data!);
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Places> getListPlacesByPost() async {
    Map data = <String, dynamic>{
      'id': 0,
      'lat': 0,
      'lng': 0,
      'name': 'string',
      'urls': ['string'],
      'placeType': 'temple',
      'description': 'string',
      //"error": "string"
    };

    final response = await dio.post<List<dynamic>>('/place', data: data);

    if (response.statusCode == 200) {
      return Places.fromJson(response.data!);
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> getPlace({required int id}) async {
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
}
