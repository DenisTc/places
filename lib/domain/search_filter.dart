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
}