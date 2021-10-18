import 'package:places/domain/place.dart';

class PlaceDto {
  final int id;
  final double? lat;
  final double? lng;
  final double? distance;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  @override
  PlaceDto({
    required this.id,
    required this.lat,
    required this.lng,
    required this.distance,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  factory PlaceDto.fromJson(Map<String, dynamic> json) {
    return PlaceDto(
      id: json['id'] as int,
      description: json['description'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      name: json['name'] as String,
      placeType: json['placeType'] as String,
      urls: List<String>.from(json['urls'] as List<dynamic>),
    );
  }
}

extension PlaceMapper on PlaceDto {
  Place toModel() {
    return Place(
      id: id,
      lat: lat,
      lng: lng,
      name: name,
      placeType: placeType,
      description: description,
      urls: urls,
    );
  }
}
