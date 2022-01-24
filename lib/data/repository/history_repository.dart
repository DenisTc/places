import 'package:places/database/database.dart';

class HistoryRepository {
  final LocalDatabase _db;

  HistoryRepository(this._db);

  Future<List<String>> loadHistory() async {
    return _db.searchHistoriesDao.allRequests().then(
          (history) => history
              .map(
                (text) => text.request,
              )
              .toList(),
        );
  }

  Future<void> saveSearchRequest(String request) async =>
      _db.searchHistoriesDao.saveSearchRequest(request);

  Future<void> deleteSearchRequest(String request) async =>
      _db.searchHistoriesDao.deleteSearchRequest(request);

  Future<void> clearSearchHistory() async =>
      _db.searchHistoriesDao.clearSearchHistory();
}
