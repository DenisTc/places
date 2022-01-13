import 'package:places/database/database.dart';

class HistoryRepository {
  final LocalDatabase _db;

  HistoryRepository(this._db);

  Future<List<String>> loadHistory() async {
    final history = await _db.searchHistoriesDao.allRequests.then(
      (history) => history
          .map(
            (text) => text.request,
          )
          .toList(),
    );
    return history;
  }

  void saveSearchRequest(String request) {
    _db.searchHistoriesDao.saveSearchRequest(request);
  }

  void deleteSearchRequest(String request) {
    _db.searchHistoriesDao.deleteSearchRequest(request);
  }

  void clearSearchHistory() {
    _db.searchHistoriesDao.clearSearchHistory();
  }
}
