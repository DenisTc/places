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
      // return (response.data as List<dynamic>)
      //     .map((place) => Place.fromJson(place))
      //     .toList();
      return Places.fromJson(response.data!);
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<List<Place>> getListPlacesByPost() async {
    final response = await dio.post<List<Place>>('/place');

    if (response.statusCode == 200) {
      // return (response.data as List<dynamic>)
      //     .map((place) => Place.fromJson(place))
      //     .toList();
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place> getPlace({required int id}) async {
    final response = await dio.get<Map<String, dynamic>>('/place/$id');

    if (response.statusCode == 200) {
      return Place.fromJson(response.data!) ;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> deletePlace(int id) async {
    final params = <String, dynamic>{'id': id};
    final response = await dio.delete<Place>('/place', queryParameters: params);

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }

  Future<Place?> putPlace(int id) async {
    final params = <String, dynamic>{'id': id};
    final response = await dio.put<Place>('/place', queryParameters: params);

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }
}
