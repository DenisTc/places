import 'package:flutter/material.dart';
import 'package:places/data/model/location.dart';

class Filters {
  List<String> category = [];
  
  late RangeValues distanceRangeValues = const RangeValues(100, 10000);

  Map<String, bool> categories = {
    'отель': false,
    'ресторан': false,
    'особое место': false,
    'парк': false,
    'музей': false,
    'кафе': false,
  };

  void setRangeValues(double lat, double lng){
    distanceRangeValues = RangeValues(lat, lng);
  }
}
