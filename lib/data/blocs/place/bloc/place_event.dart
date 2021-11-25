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