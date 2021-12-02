import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository placeRepository;
  List<String> images = [];
  PlaceBloc(this.placeRepository) : super(PlaceInitial());

  @override
  Stream<PlaceState> mapEventToState(
    PlaceEvent event,
  ) async* {
    yield PlaceDetailsLoading();

    if (event is LoadPlaceDetails) {
      try {
        var res = await placeRepository.getPlaceDetails(id: event.id);

        if (res is Place) {
          yield PlaceDetailsLoaded(res);
        } else {
          yield PlaceDetailsLoadError(res.toString());
        }
      } catch (e) {
        yield PlaceDetailsLoadError(e.toString());
      }
    }

    if (event is AddNewPlace) {
      yield AddNewPlaceInProcess();

      try {
        List<String> uploadImages = [];
        final maxId = await placeRepository.getMaxPlaceId();

        for (int i = 0; i < images.length; i++) {
          final url = await placeRepository.uploadImage(images[i]);
          uploadImages.add(url);
        }

        final newPlace = Place(
          id: maxId + 1,
          lat: event.place.lat,
          lng: event.place.lng,
          name: event.place.name,
          description: event.place.description,
          placeType: event.place.placeType,
          urls: uploadImages,
        );

        await placeRepository.addNewPlace(newPlace);

        yield AddNewPlaceSuccess();
      } catch (e) {
        yield AddNewPlaceError(e.toString());
      }
    }

    if (event is UpdatePlaceImages) {
      images = event.images;
    }
  }
}
