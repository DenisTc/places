part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

class PlaceInitial extends PlaceState {}

class PlaceDetailsLoading extends PlaceState {}

class PlaceDetailsLoaded extends PlaceState {
  final Place place;

  const PlaceDetailsLoaded(this.place);

  @override
  List<Object> get props => [place];
}

class PlaceDetailsLoadError extends PlaceState {
  final String message;

  const PlaceDetailsLoadError(this.message);

  @override
  List<Object> get props => [message];
}