import 'package:places/data/repository/history_repository.dart';

class HistoryInteractor {
  final HistoryRepository _historyRepository;

  HistoryInteractor(this._historyRepository);

  Future<List<String>> loadHistory() async =>
      await _historyRepository.loadHistory();

  Future<void> saveSearchRequest(String request) async =>
      await _historyRepository.saveSearchRequest(request);

  Future<void> deleteSearchRequest(String request) async =>
      await _historyRepository.deleteSearchRequest(request);

  Future<void> clearSearchHistory() async =>
      await _historyRepository.clearSearchHistory();
}
