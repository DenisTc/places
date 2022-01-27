import 'package:places/data/repository/history_repository.dart';

class HistoryInteractor {
  final HistoryRepository _historyRepository;

  HistoryInteractor(this._historyRepository);

  Future<List<String>> loadHistory() async => _historyRepository.loadHistory();

  Future<void> saveSearchRequest(String request) async =>
      _historyRepository.saveSearchRequest(request);

  Future<void> deleteSearchRequest(String request) async =>
      _historyRepository.deleteSearchRequest(request);

  Future<void> clearSearchHistory() async =>
      _historyRepository.clearSearchHistory();
}
