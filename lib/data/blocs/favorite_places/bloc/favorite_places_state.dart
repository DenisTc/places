part of 'favorite_places_bloc.dart';

abstract class FavoritePlaceState extends Equatable {
  const FavoritePlaceState();

  @override
  List<Object?> get props => [];
}

class FavoritePlaceInitial extends FavoritePlaceState {}

class FavoritePlaceLoading extends FavoritePlaceState {}

class PlaceCheckIsFavorite extends FavoritePlaceState {
  final Set<int> favoriteList;

  PlaceCheckIsFavorite(this.favoriteList);

  @override
  List<Object?> get props => [favoriteList];
}

class FavoritePlacesListLoading extends FavoritePlaceState {}

class FavoritePlacesListLoaded extends FavoritePlaceState {
  final List<Place> places;

  const FavoritePlacesListLoaded(this.places);

  @override
  List<Object?> get props => [places];
}

class FavoritePlaceError extends FavoritePlaceState {
  final String message;

  const FavoritePlaceError(this.message);

  @override
  List<Object?> get props => [message];
}


class PlaceCheckIsVisited extends FavoritePlaceState {
  final Map<Place, DateTime> visitedList;

  PlaceCheckIsVisited(this.visitedList);

  @override
  List<Object?> get props => [visitedList];
}

class VisitedPlacesListLoaded extends FavoritePlaceState {
  // final Map<Place, DateTime> places;
  final List<Place> places;

  const VisitedPlacesListLoaded(this.places);

  @override
  List<Object?> get props => [places];
}