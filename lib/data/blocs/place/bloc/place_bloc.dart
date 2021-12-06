import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository placeRepository;
  List<String> images = [];
  PlaceBloc(this.placeRepository) : super(PlaceInitial()) {
    on<LoadPlaceDetails>(
      (event, emit) => _loadPlaceDetails(event, emit),
    );

    on<AddNewPlace>(
      (event, emit) => _addNewPlace(event, emit),
    );

    on<UpdatePlaceImages>(
      (event, emit) => {images = event.images},
    );
  }

  void _loadPlaceDetails(
    LoadPlaceDetails event,
    Emitter<PlaceState> emit,
  ) async {
    emit(PlaceDetailsLoading());

    try {
      final place = await placeRepository.getPlaceDetails(id: event.id);

      emit(PlaceDetailsLoaded(place));
    } catch (e) {
      emit(PlaceDetailsLoadError(e.toString()));
    }
  }

  void _addNewPlace(
    AddNewPlace event,
    Emitter<PlaceState> emit,
  ) async {
    emit(AddNewPlaceInProcess());

    try {
      List<String> uploadImages = [];

      for (int i = 0; i < images.length; i++) {
        final url = await placeRepository.uploadImage(images[i]);
        uploadImages.add(url);
      }

      final newPlace = Place(
        id: null,
        lat: event.place.lat,
        lng: event.place.lng,
        name: event.place.name,
        description: event.place.description,
        placeType: event.place.placeType,
        urls: uploadImages,
      );

      await placeRepository.addNewPlace(newPlace);

      emit(AddNewPlaceSuccess());
    } catch (e) {
      emit(AddNewPlaceError(e.toString()));
    }
  }
}
