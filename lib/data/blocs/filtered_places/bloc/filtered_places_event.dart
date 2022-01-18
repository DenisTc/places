part of 'filtered_places_bloc.dart';

class FilteredPlacesEvent extends Equatable {
  const FilteredPlacesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFilteredPlaces extends FilteredPlacesEvent {
  final SearchFilter? filters;

  const LoadFilteredPlaces([this.filters]);

  @override
  List<Object> get props => [];
}

class LoadPlaceCategoriesEvent extends FilteredPlacesEvent {}
