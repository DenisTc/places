import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/search_filter.dart';
import 'package:places/services/location_services.dart';
import 'package:rxdart/rxdart.dart';

part 'filtered_places_event.dart';
part 'filtered_places_state.dart';

class FilteredPlacesBloc
    extends Bloc<FilteredPlacesEvent, FilteredPlacesState> {
  final SearchInteractor _searchInteractor;
  final SharedStorage _storage = SharedStorage();

  FilteredPlacesBloc(this._searchInteractor)
      : super(LoadFilteredPlacesInProgress()) {
    on<LoadFilteredPlaces>(
      (event, emit) => _loadFilteredPlaces(emit),
    );

    on<LoadPlaceCategoriesEvent>(
      (event, emit) => _loadPlaceCategories(emit),
    );
  }

  EventTransformer<GetProductosEvent> debounce<GetProductosEvent>(
    Duration duration,
  ) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  // Get the list of filtered places
  Future<void> _loadFilteredPlaces(
    Emitter<FilteredPlacesState> emit,
  ) async {
    try {
      LocationServices geolocation = LocationServices();
      final userLocation = await geolocation.getCurrentLocation();

      final _filter = await _storage.getSearchFilter();

      _filter.lat = userLocation.lat;
      _filter.lng = userLocation.lng;

      final _filteredPlaces = await _searchInteractor.getFiltredPlaces(_filter);

      emit(LoadFilteredPlacesSuccess(_filteredPlaces));
    } on Exception catch (e) {
      emit(LoadFilteredPlacesError(e.toString()));
    }
  }

  // Get the list of categories
  Future<void> _loadPlaceCategories(
    Emitter<FilteredPlacesState> emit,
  ) async {
    try {
      final allCategories = await _searchInteractor.getCategories();

      emit(PlaceCategoriesLoaded(categories: allCategories));
    } on Exception catch (e) {
      emit(LoadPlaceCategoriesError(e.toString()));
    }
  }
}
