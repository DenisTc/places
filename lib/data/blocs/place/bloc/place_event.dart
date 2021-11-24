part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}

class LoadPlace extends PlaceEvent {
  final int id;

  LoadPlace(this.id);

  @override
  List<Object> get props => [id];
}

// class LoadPlaceCategory extends PlaceEvent {}
