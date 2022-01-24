import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/place_with_date.dart';

part 'visited_place_event.dart';
part 'visited_place_state.dart';

class VisitedPlaceBloc extends Bloc<VisitedPlaceEvent, VisitedPlaceState> {
  final PlaceInteractor _placeInteractor;

  VisitedPlaceBloc(this._placeInteractor) : super(VisitedPlaceInitial()) {
    on<LoadListVisitedPlaces>(
      (event, emit) => _loadListVisitedPlaces(emit),
    );

    on<AddPlaceToVisitedList>(
      (event, emit) => _addPlaceToVisitedList(event),
    );
  }

  Future<void> _loadListVisitedPlaces(
    Emitter<VisitedPlaceState> emit,
  ) async {
    final visitedPlaces = await _placeInteractor.getVisitedPlaces();

    emit(ListVisitedPlacesLoaded(visitedPlaces));
  }

  Future<void> _addPlaceToVisitedList(
    AddPlaceToVisitedList event,
  ) async {
    await _placeInteractor.addPlaceToCache(event.place);
    await _placeInteractor.addPlaceToVisitedList(
      id: event.place.id!,
      date: event.date,
    );
  }
}
