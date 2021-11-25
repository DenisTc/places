part of 'category_place_bloc.dart';

abstract class PlaceCategoriesState extends Equatable {
  const PlaceCategoriesState();

  @override
  List<Object> get props => [];
}

class PlaceCategoriesInitial extends PlaceCategoriesState {}

class PlaceCategoriesLoading extends PlaceCategoriesState {}

class PlaceCategoriesLoaded extends PlaceCategoriesState {
  final List<String> categories;

  PlaceCategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class LoadPlaceCategoriesError extends PlaceCategoriesState {
  final String message;

  const LoadPlaceCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryToggled extends PlaceCategoriesState {
  final List<String> categories;

  CategoryToggled(this.categories);

  @override
  List<Object> get props => [categories];
}
