import 'package:flutter/material.dart';
import 'package:places/domain/search_filter.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;


class Filters {
  List<String> category = [];

  static SearchFilter filter = SearchFilter(
    lat: constants.userLocation.lat,
    lng: constants.userLocation.lng,
    distance: constants.defaultDistanceRange,
    typeFilter: ['other', 'monument'],
  );

  RangeValues distanceRangeValues = const RangeValues(100, 10000);

  Map<String, bool> categories = {};

  void setRangeValues(double lat, double lng) {
    distanceRangeValues = RangeValues(lat, lng);
  }
}
