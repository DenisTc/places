import 'package:flutter/material.dart';
import 'package:places/ui/res/constants.dart' as constants;

class SearchFilter {
  double? lat = constants.userLocation.lat;
  double? lng = constants.userLocation.lng;
  RangeValues? distance = constants.defaultDistanceRange;
  List<String>? typeFilter = [];
  String? nameFilter;

  SearchFilter({
    this.lat,
    this.lng,
    this.distance,
    this.typeFilter,
    this.nameFilter,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
      'radius': distance?.end,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
    };
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
        'distance': [distance!.start, distance!.end],
        'typeFilter': typeFilter,
      };

  SearchFilter.fromJson(Map<String, dynamic> json)
      : lng = json['lng'] as double,
        lat = json['lat'] as double,
        distance = RangeValues(
          (json['distance'][0] as num).toDouble(),
          (json['distance'][1] as num).toDouble(),
        ),
        typeFilter = List<String>.from(
          json['typeFilter'] as List<dynamic>,
        );
}
