import 'package:places/domain/place.dart';

/// Abstract class for interaction with place
abstract class PlaceActions {}

/// Load details place
class LoadPlaceDetailsAction extends PlaceActions {
  final int id;

  LoadPlaceDetailsAction(this.id);
}

/// Returning Error while getting the place details
class ErrorPlaceAction extends PlaceActions {
  final String message;

  ErrorPlaceAction(this.message);
}

/// Result of loading place details
class ResultPlaceDetailsAction extends PlaceActions {
  final Place place;

  ResultPlaceDetailsAction(this.place);
}
