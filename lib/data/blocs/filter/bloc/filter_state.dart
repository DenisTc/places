part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}

class LoadFiltersSuccess extends FilterState {
  final SearchFilter filter;

  LoadFiltersSuccess(this.filter);

  @override
  List<Object> get props => [filter];
}

class LoadFiltersError extends FilterState {
  final String message;

  LoadFiltersError(this.message);

  @override
  List<Object> get props => [message];
}

class LoadFilterCategoriesSuccess extends FilterState {
  final List<String> categories;

  LoadFilterCategoriesSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

class LoadFilterCategoriesError extends FilterState {
  final String message;

  LoadFilterCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}

class LoadFilterDistanceSuccess extends FilterState {
  final RangeValues _distance;

  LoadFilterDistanceSuccess(this._distance);

  @override
  List<Object> get props => [_distance];
}

class LoadCountFilteredPlacesSuccess extends FilterState {
  final int count;

  LoadCountFilteredPlacesSuccess(this.count);

  @override
  List<Object> get props => [count];
}
