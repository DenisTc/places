import 'package:flutter/material.dart';

class SettingsFilter {
  double? lat;
  double? lng;
  RangeValues? distance;
  List<String>? typeFilter;
  String? nameFilter;

  SettingsFilter({
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
