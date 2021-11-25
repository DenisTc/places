part of 'favorite_place_bloc.dart';

abstract class FavoritePlaceState extends Equatable {
  const FavoritePlaceState();

  @override
  List<Object> get props => [];
}

class FavoritePlaceInitial extends FavoritePlaceState {}

class ListFavoritePlacesLoading extends FavoritePlaceState {}

class ListFavoritePlacesLoaded extends FavoritePlaceState {
  final Set<int> favoriteList;

  ListFavoritePlacesLoaded(this.favoriteList);

  @override
  List<Object> get props => [favoriteList];
}
