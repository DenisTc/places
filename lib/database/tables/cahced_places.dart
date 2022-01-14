import 'package:drift/drift.dart';
import 'package:places/database/type_converters/place_converter.dart';

// Table containing descriptions of places
class CachedPlaces extends Table {
  IntColumn get id => integer()();
  TextColumn get place => text().map(PlaceConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
