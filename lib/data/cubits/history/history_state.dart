
part of 'history_cubit.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<String> history;

  HistoryLoadedState(this.history);
}

class HistoryErrorState extends HistoryState {
  final String errorMessage;

  HistoryErrorState(this.errorMessage);
}