import 'package:flutter/material.dart';

class SettingsFilter {
  final double? lat;
  final double? lng;
  final RangeValues? distance;
  final List<String>? typeFilter;
  final String? nameFilter;

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
