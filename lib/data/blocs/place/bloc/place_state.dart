part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

class PlaceInitial extends PlaceState {}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final Place place;

  const PlaceLoaded(this.place);

  @override
  List<Object> get props => [place];
}

class PlaceError extends PlaceState {
  final String message;

  const PlaceError(this.message);

  @override
  List<Object> get props => [message];
}
