// import 'package:json_annotation/json_annotation.dart';

// part 'place.g.dart';

// @JsonSerializable()
class Place {
  final int id;
  final double? lat;
  final double? lon;
  final String name;
  final List<dynamic> urls;
  final String placeType;
  final String description;

  Place({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        lat = (json['lat'] as num?)?.toDouble(),
        lon = (json['lon'] as num?)?.toDouble(),
        name = json['name'] as String,
        urls = json['urls'] as List<dynamic>,
        placeType = json['placeType'] as String,
        description = json['description'] as String;

  // factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  // Map<String, dynamic> toJson() => _$PlaceToJson(this);
}

class Places {
  final List<Place> places;

  Places({required this.places});

  factory Places.fromJson(List<dynamic> json) {
    List<Place> placesList;
    placesList = json
        .map((dynamic place) => Place.fromJson(place as Map<String, dynamic>))
        .toList();
    return Places(places: placesList);
  }

  // Places.fromJson(List<Place> json) : places = json;
}