part of 'filter_bloc.dart';

class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class LoadFilterEvent extends FilterEvent {}

class ToggleCategoryEvent extends FilterEvent {
  final String name;

  ToggleCategoryEvent(this.name);

  @override
  List<Object> get props => [name];
}

class UpdateFilterDistanceEvent extends FilterEvent {
  final RangeValues distance;

  UpdateFilterDistanceEvent(this.distance);

  @override
  List<Object> get props => [distance];
}

class SaveFilterEvent extends FilterEvent {}

class ClearFilterEvent extends FilterEvent {}
