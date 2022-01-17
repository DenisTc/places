import 'package:drift/drift.dart';
import 'package:places/database/database.dart';
import 'package:places/database/tables/search_histories.dart';

part 'search_histories_dao.g.dart';

@DriftAccessor(tables: [SearchHistories])
class SearchHistoriesDao extends DatabaseAccessor<LocalDatabase>
    with _$SearchHistoriesDaoMixin {
  SearchHistoriesDao(LocalDatabase db) : super(db);

  // Read
  Future<List<SearchHistorie>> get allRequests => select(searchHistories).get();

  // Create
  void saveSearchRequest(String request) => into(searchHistories)
      .insert(SearchHistoriesCompanion(request: Value(request)))
      .ignore();

  // Delete
  Future<void> deleteSearchRequest(String text) async =>
      await (delete(searchHistories)..where((tbl) => tbl.request.equals(text)))
          .go();

  Future<void> clearSearchHistory() async => await delete(searchHistories).go();
}
