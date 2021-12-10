import 'package:places/domain/place.dart';

/// Abstract class for interaction with filtered places
abstract class FilteredPlacesActions {}

/// Load filtered places
class LoadFilteredPlacesAction extends FilteredPlacesActions {}

/// Returning Error while getting the list of filtered places
class ErrorFilteredPlacesAction extends FilteredPlacesActions {
  final String message;

  ErrorFilteredPlacesAction(this.message);
}

/// Result of loading filtered places
class ResultFilteredPlacesAction extends FilteredPlacesActions {
  final List<Place> places;

  ResultFilteredPlacesAction(this.places);
}
