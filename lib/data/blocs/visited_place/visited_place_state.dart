part of 'visited_place_bloc.dart';

abstract class VisitedPlaceState extends Equatable {
  const VisitedPlaceState();

  @override
  List<Object> get props => [];
}

class VisitedPlaceInitial extends VisitedPlaceState {}

class ListVisitedPlacesLoading extends VisitedPlaceState {}

class ListVisitedPlacesLoaded extends VisitedPlaceState {
  final List<PlaceWithDate> visitedPlaces;

  ListVisitedPlacesLoaded(this.visitedPlaces);

  @override
  List<Object> get props => [visitedPlaces];
}
