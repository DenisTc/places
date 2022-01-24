part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}

class LoadFiltersSuccess extends FilterState {
  final SearchFilter filter;

  const LoadFiltersSuccess(this.filter);

  @override
  List<Object> get props => [filter];
}

class LoadFiltersError extends FilterState {
  final String message;

  const LoadFiltersError(this.message);

  @override
  List<Object> get props => [message];
}

class LoadFilterCategoriesSuccess extends FilterState {
  final List<String> categories;

  const LoadFilterCategoriesSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

class LoadFilterCategoriesError extends FilterState {
  final String message;

  const LoadFilterCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}

class LoadFilterDistanceSuccess extends FilterState {
  final RangeValues _distance;

  const LoadFilterDistanceSuccess(this._distance);

  @override
  List<Object> get props => [_distance];
}

class LoadCountFilteredPlacesSuccess extends FilterState {
  final int count;

  const LoadCountFilteredPlacesSuccess(this.count);

  @override
  List<Object> get props => [count];
}
