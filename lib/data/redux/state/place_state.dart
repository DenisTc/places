import 'package:places/domain/place.dart';

/// State of place
abstract class PlaceState {}

class PlaceInitialState extends PlaceState {}

class PlaceLoadingState extends PlaceState {}

class PlaceErrorState extends PlaceState {
  final String message;

  PlaceErrorState(this.message);
}

class PlaceDataState extends PlaceState {
  final Place place;

  PlaceDataState(this.place);
}

class AddnewPlaceSuccessState extends PlaceState {}

class AddnewPlaceInProcessState extends PlaceState {}

class AddnewPlaceErrorState extends PlaceState {
  final String message;

  AddnewPlaceErrorState(this.message);
}
