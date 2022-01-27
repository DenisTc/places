part of 'filtered_places_bloc.dart';

class FilteredPlacesEvent extends Equatable {
  const FilteredPlacesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFilteredPlaces extends FilteredPlacesEvent {
  final SearchFilter? filters;
  final bool defaultGeo;

  const LoadFilteredPlaces({this.filters, this.defaultGeo = false});

  @override
  List<Object> get props => [];
}

class LoadPlaceCategoriesEvent extends FilteredPlacesEvent {}
