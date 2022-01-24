part of 'places_map_bloc.dart';

class PlacesMapEvent extends Equatable {
  const PlacesMapEvent();

  @override
  List<Object?> get props => [];
}

class LoadPlacesMapEvent extends PlacesMapEvent {}

class LoadPlaceCardEvent extends PlacesMapEvent {
  final Place place;

  const LoadPlaceCardEvent(this.place);
}

class HidePlaceCardEvent extends PlacesMapEvent {}

class LoadCurrentUserLocationEvent extends PlacesMapEvent {}
