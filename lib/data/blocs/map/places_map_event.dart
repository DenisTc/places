part of 'places_map_bloc.dart';

class PlacesMapEvent extends Equatable {
  const PlacesMapEvent();

  @override
  List<Object?> get props => [];
}

class LoadPlacesMapEvent extends PlacesMapEvent {
  final bool defaultGeo;
  final bool defineUserLocation;

  const LoadPlacesMapEvent({
    this.defaultGeo = false,
    this.defineUserLocation = false,
  });

  @override
  List<Object?> get props => [defaultGeo, defineUserLocation];
}

class LoadPlaceCardEvent extends PlacesMapEvent {
  final Place place;

  const LoadPlaceCardEvent(this.place);
}

class HidePlaceCardEvent extends PlacesMapEvent {}
