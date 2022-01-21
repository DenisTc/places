part of 'places_map_bloc.dart';

abstract class PlacesMapState extends Equatable {
  const PlacesMapState();

  @override
  List<Object> get props => [];
}

class PlacesMapInitial extends PlacesMapState {}

class LoadPlacesMapSuccess extends PlacesMapState {
  final Location userLocation;
  final List<Place> places;

  LoadPlacesMapSuccess({
    required this.userLocation,
    required this.places,
  });

  @override
  List<Object> get props => [userLocation, places];
}

class LoadPlaceCardSuccess extends PlacesMapState {
  final Place place;

  LoadPlaceCardSuccess(this.place);

  @override
  List<Object> get props => [place];
}

class HidePlaceCardState extends PlacesMapState {}

class LoadCurrentUserLocationSuccess extends PlacesMapState {
  final Location userLocation;

  LoadCurrentUserLocationSuccess(this.userLocation);

  @override
  List<Object> get props => [userLocation];
}
