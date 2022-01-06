part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaceDetails extends PlaceEvent {
  final int id;

  LoadPlaceDetails(this.id);

  @override
  List<Object> get props => [id];
}

class AddNewPlace extends PlaceEvent {
  final Place place;
  final List<String> images;

  AddNewPlace({required this.place, required this.images});

  @override
  List<Object> get props => [place];
}

class UpdatePlaceImages extends PlaceEvent {
  final List<String> images;

  UpdatePlaceImages(this.images);

  @override
  List<Object> get props => [images];
}

