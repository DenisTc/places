part of 'visited_place_bloc.dart';

abstract class VisitedPlaceEvent extends Equatable {
  const VisitedPlaceEvent();

  @override
  List<Object> get props => [];
}

class LoadListVisitedPlaces extends VisitedPlaceEvent {}

class AddPlaceToVisitedList extends VisitedPlaceEvent {
  final Place place;
  final DateTime date;

  AddPlaceToVisitedList({
    required this.place,
    required this.date,
  });
}

class UpdateVisitedPlace extends VisitedPlaceEvent {
  final Place place;
  final DateTime date;

  UpdateVisitedPlace({
    required this.place,
    required this.date,
  });
}