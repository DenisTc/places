part of 'favorite_places_bloc.dart';

abstract class FavoritePlaceEvent extends Equatable {
  const FavoritePlaceEvent();

  @override
  List<Object> get props => [];
}

class PlaceIsFavorite extends FavoritePlaceEvent {
  final Place place;

  PlaceIsFavorite(this.place);

  @override
  List<Object> get props => [];
}

class PlaceToggleFavorite extends FavoritePlaceEvent {
  final int id;

  PlaceToggleFavorite(this.id);

  @override
  List<Object> get props => [];
}

class PlaceToggleInFavorites extends FavoritePlaceEvent {
  final Place place;

  PlaceToggleInFavorites(this.place);

  @override
  List<Object> get props => [];
}

class LoadFavoritePlaces extends FavoritePlaceEvent {
  final List<Place> places;

  LoadFavoritePlaces(this.places);

  @override
  List<Object> get props => [places];
}

class LoadAllFavoritePlaces extends FavoritePlaceEvent {}

class PlaceToggleInVisited extends FavoritePlaceEvent {
  final Place place;
  final DateTime date;

  PlaceToggleInVisited({required this.place, required this.date});

  @override
  List<Object> get props => [place, date];
}

class LoadVisitedPlaces extends FavoritePlaceEvent {
  final List<Place> places;

  LoadVisitedPlaces(this.places);

  @override
  List<Object> get props => [places];
}

class LoadAllVisitedPlaces extends FavoritePlaceEvent {}

class PlaceIsVisited extends FavoritePlaceEvent {
  final Place place;

  PlaceIsVisited(this.place);

  @override
  List<Object> get props => [];
}

// class ScheduleVisitDate extends FavoritePlaceEvent {
//   final Place place;
//   final DateTime date;

//   ScheduleVisitDate(this.place, this.date);

//   @override
//   List<Object> get props => [];
// }