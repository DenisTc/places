part of 'filtered_places_bloc.dart';

abstract class FilteredPlacesState extends Equatable {
  const FilteredPlacesState();

  @override
  List<Object> get props => [];
}

class LoadFilteredPlacesInProgress extends FilteredPlacesState {}

class LoadFilteredPlacesError extends FilteredPlacesState {
  final String message;

  const LoadFilteredPlacesError(this.message);

  @override
  List<Object> get props => [message];
}

class LoadFilteredPlacesSuccess extends FilteredPlacesState {
  final List<Place> places;

  const LoadFilteredPlacesSuccess(this.places);

  @override
  List<Object> get props => [places];
}

class PlaceCategoriesLoading extends FilteredPlacesState {}

class PlaceCategoriesLoaded extends FilteredPlacesState {
  final List<String> categories;

  const PlaceCategoriesLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

class LoadPlaceCategoriesError extends FilteredPlacesState {
  final String message;

  const LoadPlaceCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
