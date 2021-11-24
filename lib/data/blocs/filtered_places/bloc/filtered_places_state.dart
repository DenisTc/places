import 'package:equatable/equatable.dart';
import 'package:places/domain/place.dart';

abstract class FilteredPlacesState extends Equatable {
  const FilteredPlacesState();

  @override
  List<Object?> get props => [];
}

class LoadFilteredPlacesInProgress extends FilteredPlacesState {}

class LoadFilteredPlacesError extends FilteredPlacesState {
  final String message;

  const LoadFilteredPlacesError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoadFilteredPlacesSuccess extends FilteredPlacesState {
  final List<Place> places;

  const LoadFilteredPlacesSuccess(this.places);

  @override
  List<Object?> get props => [places];
}
