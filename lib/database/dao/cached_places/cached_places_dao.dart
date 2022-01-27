import 'package:drift/drift.dart';
import 'package:places/database/database.dart';
import 'package:places/database/tables/cahced_places.dart';
import 'package:places/database/tables/favorite_places.dart';
import 'package:places/database/tables/visited_places.dart';
import 'package:places/domain/place.dart';

part 'cached_places_dao.g.dart';

@DriftAccessor(tables: [CachedPlaces, FavoritePlaces, VisitedPlaces])
class CachedPlacesDao extends DatabaseAccessor<LocalDatabase>
    with _$CachedPlacesDaoMixin {
  CachedPlacesDao(LocalDatabase db) : super(db);

  // Read
  Future<List<CachedPlace>> getAllCachedPlaces() => select(cachedPlaces).get();

  // Create
  Future<void> addPlaceToCache(Place place) async => into(cachedPlaces)
      .insert(
        CachedPlacesCompanion(id: Value(place.id!), place: Value(place)),
      )
      .ignore();

  // Delete
  // The place will be deleted only if it is not in the list of visited places
  Future<void> deletePlaceFromCache(int id) async {
    final isVisited = (await (select(visitedPlaces)
              ..where((tbl) => tbl.placeId.equals(id)))
            .get())
        .isNotEmpty;

    if (!isVisited) {
      await (delete(cachedPlaces)..where((tbl) => tbl.id.equals(id))).go();
    }
  }
}
