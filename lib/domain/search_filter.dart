import 'package:flutter/material.dart';
import 'package:places/ui/res/constants.dart' as constants;

class SearchFilter {
  double? lat;
  double? lng;
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

  factory SearchFilter.fromJson(Map<String, dynamic> json) {
    if (json['lat'] == null) {
      return SearchFilter(typeFilter: []);
    }

    return SearchFilter(
      lng: json['lng'] as double,
      lat: json['lat'] as double,
      distance: RangeValues(
        // ignore: avoid_dynamic_calls
        (json['distance'][0] as num).toDouble(),
        // ignore: avoid_dynamic_calls
        (json['distance'][1] as num).toDouble(),
      ),
      typeFilter: List<String>.from(
        json['typeFilter'] as List<dynamic>,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
      'radius': distance?.end,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
    };
  }

  Map<String, dynamic> toJson() {
    if (lat == null) {
      return <String, dynamic>{};
    }

    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
      'distance': [distance!.start, distance!.end],
      'typeFilter': typeFilter,
    };
  }
}
