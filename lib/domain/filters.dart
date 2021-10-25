import 'package:flutter/material.dart';

class Filters {
  List<String> category = [];

  RangeValues distanceRangeValues = const RangeValues(100, 10000);

  Map<String, bool> categories = {};

  void setRangeValues(double lat, double lng) {
    distanceRangeValues = RangeValues(lat, lng);
  }
}
