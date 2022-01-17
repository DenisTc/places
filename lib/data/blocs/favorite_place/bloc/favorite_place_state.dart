part of 'favorite_place_bloc.dart';

abstract class FavoritePlaceState extends Equatable {
  const FavoritePlaceState();

  @override
  List<Object> get props => [];
}

class FavoritePlaceInitial extends FavoritePlaceState {}

class ListFavoritePlacesLoading extends FavoritePlaceState {}

class ListFavoritePlacesLoaded extends FavoritePlaceState {
  final List<Place> places;

  ListFavoritePlacesLoaded(this.places);

  @override
  List<Object> get props => [places];
}