import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceInteractor placeInteractor;

  PlaceBloc(this.placeInteractor) : super(PlaceInitial()) {
    on<LoadPlaceDetails>(_loadPlaceDetails);

    on<AddNewPlace>(_addNewPlace);
  }

  Future<void> _loadPlaceDetails(
    LoadPlaceDetails event,
    Emitter<PlaceState> emit,
  ) async {
    emit(PlaceDetailsLoading());

    try {
      final place = await placeInteractor.getPlaceDetails(id: event.id);

      emit(PlaceDetailsLoaded(place));
    } on Exception catch (e) {
      emit(PlaceDetailsLoadError(e.toString()));
    }
  }

  Future<void> _addNewPlace(
    AddNewPlace event,
    Emitter<PlaceState> emit,
  ) async {
    emit(AddNewPlaceInProcess());

    try {
      final uploadImages = <String>[];

      for (var i = 0; i < event.images.length; i++) {
        final url = await placeInteractor.uploadImage(event.images[i]);
        uploadImages.add(url);
      }

      final placeType = Category.getCategoryByName(event.place.placeType).type;
      final newPlace = Place(
        lat: event.place.lat,
        lng: event.place.lng,
        name: event.place.name,
        description: event.place.description,
        placeType: placeType,
        urls: uploadImages,
      );

      await placeInteractor.addNewPlace(newPlace);

      emit(AddNewPlaceSuccess());
    } on Exception catch (e) {
      emit(AddNewPlaceError(e.toString()));
    }
  }
}
