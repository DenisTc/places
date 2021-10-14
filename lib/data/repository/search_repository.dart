import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:places/data/model/place_dto.dart';

final dio = Dio(baseOptions);

BaseOptions baseOptions = BaseOptions(
  baseUrl: 'https://test-backend-flutter.surfstudio.ru',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  responseType: ResponseType.json,
);

class SearchRepository {
  Future<List<PlaceDto>> searchPlaces({
    double? lat,
    double? lng,
    double? radius,
    List<String>? typeFilter,
    String? nameFilter,
  }) async {
    final data = {
      'lat' : lat,
      'lng' : lng,
      'radius': radius,
      'typeFilter' : typeFilter,
      'nameFilter': nameFilter,
    };

    final response = await dio
        .post<String>('/filtered_places', data: data);
    if (response.statusCode == 200) {
      final placesList = (jsonDecode(response.toString()) as List<dynamic>)
          .map((dynamic place) => PlaceDto.fromJson(place as Map<String, dynamic>))
          .toList();
      return placesList;
    }

    throw Exception(
      'HTTP request error. Error code ${response.statusCode}',
    );
  }
}
