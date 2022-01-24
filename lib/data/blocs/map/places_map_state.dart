part of 'places_map_bloc.dart';

abstract class PlacesMapState extends Equatable {
  const PlacesMapState();

  @override
  List<Object?> get props => [];
}

class PlacesMapInitial extends PlacesMapState {}

class LoadPlacesMapSuccess extends PlacesMapState {
  final List<Place> places;
  final Location? userLocation;

  const LoadPlacesMapSuccess({
    required this.places,
    this.userLocation,
  });

  // @override
  // List<Object?> get props => [places, userLocation];
  @override
  List<Object?> get props => [places, userLocation];
}

class LoadPlaceCardSuccess extends PlacesMapState {
  final Place place;

  const LoadPlaceCardSuccess(this.place);

  @override
  List<Object> get props => [place];
}

class HidePlaceCardState extends PlacesMapState {}

class LoadCurrentUserLocationSuccess extends PlacesMapState {
  final Location userLocation;

  const LoadCurrentUserLocationSuccess(this.userLocation);

  @override
  List<Object> get props => [userLocation];
}
