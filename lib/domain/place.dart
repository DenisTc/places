import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final int? id;
  final double? lat;
  final double? lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  @override
  List<Object?> get props => [id, lat, lng, name, urls, placeType, description];

  const Place({
    this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        lat = json['lat'] as double,
        lng = json['lng'] as double,
        name = json['name'] as String,
        urls = (json['urls'] as List<dynamic>).cast<String>(),
        placeType = json['placeType'] as String,
        description = json['description'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'lat': lat,
        'lng': lng,
        'name': name,
        'urls': urls,
        'placeType': placeType,
        'description': description,
      };
}
