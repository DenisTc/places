import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:places/domain/place.dart';

// Stores place as strings
class PlaceConverter extends TypeConverter<Place, String> {
  const PlaceConverter();

  @override
  Place? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }

    return Place.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String? mapToSql(Place? value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}
