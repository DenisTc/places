import 'package:places/domain/place.dart';

// A class for getting the result of a join sql query
// Documentation https://drift.simonbinder.eu/docs/advanced-features/joins/
class PlaceWithDate {
  final Place place;
  final DateTime? date;

  PlaceWithDate({
    required this.place,
    required this.date,
  });
}
