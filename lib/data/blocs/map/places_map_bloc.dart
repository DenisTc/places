import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/place.dart';

part 'places_map_event.dart';
part 'places_map_state.dart';

class PlacesMapBloc extends Bloc<PlacesMapEvent, PlacesMapState> {
  final SearchInteractor searchInteractor;
  final SharedStorage storage;

  PlacesMapBloc({
    required this.searchInteractor,
    required this.storage,
  }) : super(PlacesMapInitial()) {
    on<LoadPlacesMapEvent>(
      (event, emit) => _loadPlacesMap(event, emit),
    );

    on<LoadPlaceCardEvent>(
      (event, emit) => emit(LoadPlaceCardSuccess(event.place)),
    );

    on<HidePlaceCardEvent>(
      (event, emit) => emit(HidePlaceCardState()),
    );

    on<LoadCurrentUserLocationEvent>(
      (event, emit) => emit(HidePlaceCardState()),
    );
  }

  Future<void> _loadPlacesMap(
    LoadPlacesMapEvent event,
    Emitter<PlacesMapState> emit,
  ) async {
    final _filter = await storage.getSavedSearchFilter();
    final _filteredPlaces = await searchInteractor.getFiltredPlaces(_filter);

    emit(
      LoadPlacesMapSuccess(
        places: _filteredPlaces,
      ),
    );
  }
}
