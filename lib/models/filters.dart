import 'package:flutter/material.dart';

class Filters {
  List<String> category = [];
  late RangeValues currentRangeValues = const RangeValues(100, 10000);
  Map<String, bool> categories = {
    'отель': false,
    'ресторан': false,
    'особое место': false,
    'парк': false,
    'музей': false,
    'кафе': false,
  };

  setRangeValues(double lat, double lon){
    currentRangeValues = RangeValues(lat, lon);
  }
}
