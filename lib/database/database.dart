import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/database/dao/cached_places/cached_places_dao.dart';
import 'package:places/database/dao/favorite_places/favorite_places_dao.dart';
import 'package:places/database/dao/search_histories_dao/search_histories_dao.dart';
import 'package:places/database/tables/favorite_places.dart';
import 'package:places/database/tables/cahced_places.dart';
import 'package:places/database/tables/search_histories.dart';
import 'package:places/database/type_converters/place_converter.dart';
import 'package:places/domain/place.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [CachedPlaces, FavoritePlaces, SearchHistories],
  daos: [CachedPlacesDao, FavoritePlacesDao, SearchHistoriesDao],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
