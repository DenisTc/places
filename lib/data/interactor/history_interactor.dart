import 'package:places/data/repository/history_repository.dart';

class HistoryInteractor {
  final HistoryRepository _historyRepository;

  HistoryInteractor(this._historyRepository);

  Future<List<String>> loadHistory() async {
    return _historyRepository.loadHistory();
  }

  void saveSearchRequest(String request) {
    _historyRepository.saveSearchRequest(request);
  }

  void deleteSearchRequest(String request) {
    _historyRepository.deleteSearchRequest(request);
  }

  void clearSearchHistory() {
    _historyRepository.clearSearchHistory();
  }
}
