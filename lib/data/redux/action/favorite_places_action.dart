import 'package:places/domain/place.dart';

/// Abstract class for interaction with favorite places
abstract class FavoritePlacesActions {}

/// Load favorite places
class LoadFavoritePlacesAction extends FavoritePlacesActions {}

/// Result of loading favorite places
class ResultFavoritePlacesAction extends FavoritePlacesActions {
  final List<Place> places;

  ResultFavoritePlacesAction(this.places);
}

/// Adds or removes from the favorites list depending on the current state
class ToggleInFavoriteAction extends FavoritePlacesActions {
  final Place place;

  ToggleInFavoriteAction(this.place);
}
