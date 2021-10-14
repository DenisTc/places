import 'package:places/data/model/place.dart';

class PlaceDto extends Place {
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
  }) : super(
          id: id,
          lat: lat,
          lng: lng,
          name: name,
          urls: urls,
          placeType: placeType,
          description: description,
        );

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