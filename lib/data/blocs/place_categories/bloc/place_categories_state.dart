part of 'place_categories_bloc.dart';

abstract class PlaceCategoriesState extends Equatable {
  const PlaceCategoriesState();
  
  @override
  List<Object> get props => [];
}

class PlaceCategoriesInitial extends PlaceCategoriesState {}

class PlaceCategoriesLoading extends PlaceCategoriesState {}

class PlaceCategoriesLoaded extends PlaceCategoriesState {
  final List<String> categories;

  const PlaceCategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class PlaceCategoriesError extends PlaceCategoriesState {
  final String message;

  const PlaceCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
