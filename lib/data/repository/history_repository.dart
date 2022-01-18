import 'package:places/database/database.dart';

class HistoryRepository {
  final LocalDatabase _db;

  HistoryRepository(this._db);

  Future<List<String>> loadHistory() async {
    final history = await _db.searchHistoriesDao.allRequests().then(
      (history) => history
          .map(
            (text) => text.request,
          )
          .toList(),
    );
    return history;
  }

  Future<void> saveSearchRequest(String request) async =>
      await _db.searchHistoriesDao.saveSearchRequest(request);

  Future<void> deleteSearchRequest(String request) async =>
      await _db.searchHistoriesDao.deleteSearchRequest(request);

  Future<void> clearSearchHistory() async =>
      await _db.searchHistoriesDao.clearSearchHistory();
}
