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

/// Action for working with a remote repository
class AddNewPlaceAction extends PlaceActions {
  final Place place;

  AddNewPlaceAction(this.place);
}

class ErrorAddNewPlaceAction extends PlaceActions {
  final String message;

  ErrorAddNewPlaceAction(this.message);
}

class ResultAddNewPlaceAction extends PlaceActions {}

///-------------
class UpdatePlaceImagesAction extends PlaceActions {
  final List<String> images;

  UpdatePlaceImagesAction(this.images);
}