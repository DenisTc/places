import 'package:drift/drift.dart';
import 'package:places/database/database.dart';
import 'package:places/database/tables/cahced_places.dart';
import 'package:places/database/tables/visited_places.dart';
import 'package:places/domain/place_with_date.dart';

part 'visited_places_dao.g.dart';

@DriftAccessor(tables: [VisitedPlaces, CachedPlaces])
class VisitedPlacesDao extends DatabaseAccessor<LocalDatabase>
    with _$VisitedPlacesDaoMixin {
  VisitedPlacesDao(LocalDatabase db) : super(db);

  // Read
  Future<List<PlaceWithDate>> loadVisitedPlaces() async {
    return (select(visitedPlaces).join(
      [
        leftOuterJoin(
          cachedPlaces,
          cachedPlaces.id.equalsExp(visitedPlaces.placeId),
        ),
      ],
    ).map(
      (resultRow) {
        return PlaceWithDate(
          place: resultRow.readTable(cachedPlaces).place!,
          date: resultRow.readTable(visitedPlaces).date,
        );
      },
    )).get();
  }

  // Create
  // Adding place. If a place already exists, method "insertOnConflictUpdate" update the data.
  Future<void> addPlaceToVisitedList({
    required int id,
    required DateTime date,
  }) async =>
      into(visitedPlaces).insertOnConflictUpdate(
        VisitedPlacesCompanion(
          placeId: Value(id),
          date: Value(date),
        ),
      );
}
