import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:places/database/database.dart';
import 'package:places/database/tables/cahced_places.dart';
import 'package:places/database/tables/favorite_places.dart';
import 'package:places/domain/place.dart';

part 'cached_places_dao.g.dart';

@DriftAccessor(tables: [FavoritePlaces, CachedPlaces])
class CachedPlacesDao extends DatabaseAccessor<LocalDatabase>
    with _$CachedPlacesDaoMixin {
  CachedPlacesDao(LocalDatabase db) : super(db);

  // Read
  Future<List<CachedPlace>> getAllCachedPlaces() async {
    final places = await select(cachedPlaces).get();
    return places;
  }

  // Create
  void addPlaceToCache(Place place) => into(cachedPlaces).insert(
        CachedPlacesCompanion(id: Value(place.id!), place: Value(place)),
      );

  // Delete
  Future<void> deletePlaceFromCache(int id) async =>
      await (delete(cachedPlaces)..where((tbl) => tbl.id.equals(id))).go();
}
