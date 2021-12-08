import 'package:places/domain/place.dart';

/// State of filtered places
abstract class FilteredPlacesState {}

class FilteredPlacesInitialState extends FilteredPlacesState {}

class FilteredPlacesLoadingState extends FilteredPlacesState {}

class FilteredPlacesErrorState extends FilteredPlacesState {
  final String message;

  FilteredPlacesErrorState(this.message);
}

class FilteredPlacesDataState extends FilteredPlacesState {
  final List<Place> places;

  FilteredPlacesDataState(this.places);
}
