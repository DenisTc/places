import 'package:places/domain/place.dart';

/// State of favorite places
abstract class FavoritePlacesState {}

class FavoritePlacesInitialState extends FavoritePlacesState {}

class FavoritePlacesLoadingState extends FavoritePlacesState {}

class FavoritePlacesDataState extends FavoritePlacesState {
  final List<Place> places;

  FavoritePlacesDataState(this.places);
}
