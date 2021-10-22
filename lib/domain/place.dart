import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final int id;
  final double? lat;
  final double? lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  @override
  List<Object?> get props => [id, lat, lng, name, urls, placeType, description];

  const Place({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });
}
