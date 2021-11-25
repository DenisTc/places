part of 'favorite_place_bloc.dart';

abstract class FavoritePlaceEvent extends Equatable {
  const FavoritePlaceEvent();

  @override
  List<Object> get props => [];
}

class TogglePlaceInFavorites extends FavoritePlaceEvent {
  final Place place;

  TogglePlaceInFavorites(this.place);

  @override
  List<Object> get props => [place];
}

class LoadListFavoritePlaces extends FavoritePlaceEvent {}

class RemovePlaceFromFavoritesList extends FavoritePlaceEvent {
  final Place place;

  RemovePlaceFromFavoritesList(this.place);

  @override
  List<Object> get props => [place];
}