part of 'favorite_place_bloc.dart';

abstract class FavoritePlaceEvent extends Equatable {
  const FavoritePlaceEvent();

  @override
  List<Object> get props => [];
}

class LoadListFavoritePlaces extends FavoritePlaceEvent {}

class TogglePlaceInFavorites extends FavoritePlaceEvent {
  final Place place;

  TogglePlaceInFavorites(this.place);

  @override
  List<Object> get props => [place];
}