import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/history_interactor.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryInteractor _historyInteractor;
  HistoryCubit(this._historyInteractor) : super(HistoryInitial());

  Future<void> loadHistory() async {
    try {
      final history = await _historyInteractor.loadHistory();
      emit(HistoryLoadedState(history));
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }

  Future<void> clearSearchHistory() async {
    try {
      _historyInteractor.clearSearchHistory();
      emit(HistoryLoadedState([]));
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }

  Future<void> deleteSearchRequest(String request) async {
    try {
      _historyInteractor.deleteSearchRequest(request);
      final history = await _historyInteractor.loadHistory();
      emit(HistoryLoadedState(history));
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }

  Future<void> saveSearchRequest(String request) async {
    try {
      _historyInteractor.saveSearchRequest(request);
      final history = await _historyInteractor.loadHistory();
      emit(HistoryLoadedState(history));
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }
}
