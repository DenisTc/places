import 'package:drift/drift.dart';

// The table contains the places visited and the date of their visit
class VisitedPlaces extends Table {
  IntColumn get placeId => integer()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {placeId};
}