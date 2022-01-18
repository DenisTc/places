import 'package:drift/drift.dart';
import 'package:places/database/database.dart';
import 'package:places/database/tables/favorite_places.dart';
import 'package:places/database/tables/cahced_places.dart';
import 'package:places/domain/place.dart';

part 'favorite_places_dao.g.dart';

@DriftAccessor(tables: [FavoritePlaces, CachedPlaces])
class FavoritePlacesDao extends DatabaseAccessor<LocalDatabase>
    with _$FavoritePlacesDaoMixin {
  FavoritePlacesDao(LocalDatabase db) : super(db);

  // Read
  Future<List<Place>> loadFavoritePlaces() async {
    return await (select(favoritePlaces).join(
      [
        leftOuterJoin(
          cachedPlaces,
          cachedPlaces.id.equalsExp(favoritePlaces.placeId),
        ),
      ],
    ).map(
      (resultRow) {
        return resultRow.readTable(cachedPlaces).place!;
      },
    )).get();
  }

  Future<bool> isFavoritePlaceExist(int id) async {
    final rows = await (select(favoritePlaces)
          ..where((tbl) => tbl.placeId.equals(id)))
        .get();
    return rows.isNotEmpty ? true : false;
  }

  // Create
  void addPlaceToFavorites(int id) =>
      into(favoritePlaces).insert(FavoritePlacesCompanion(placeId: Value(id)));

  // Delete
  Future<void> deletePlaceFromFavorites(int id) async =>
      (delete(favoritePlaces)..where((tbl) => tbl.placeId.equals(id))).go();
}
