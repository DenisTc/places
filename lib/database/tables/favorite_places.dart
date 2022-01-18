import 'package:drift/drift.dart';

// Table contains the id of favorite places
class FavoritePlaces extends Table {
  IntColumn get placeId => integer()();

  @override
  Set<Column> get primaryKey => {placeId};
}
