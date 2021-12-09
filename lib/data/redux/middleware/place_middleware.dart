import 'package:places/data/redux/action/place_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';
import 'package:redux/redux.dart';

class PlaceMiddleware implements MiddlewareClass<AppState> {
  final PlaceRepository _placeRepository;
  List<String> uploadImages = [];

  PlaceMiddleware(this._placeRepository);

  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is LoadPlaceDetailsAction) {
      _placeRepository
          .getPlaceDetails(id: action.id)
          .then((result) => store.dispatch(ResultPlaceDetailsAction(result)))
          .catchError(
              (errMsg) => store.dispatch(ErrorPlaceAction(errMsg.toString())));
    }

    if (action is UpdatePlaceImagesAction) {
      for (int i = 0; i < action.images.length; i++) {
        final url = await _placeRepository.uploadImage(action.images[i]);
        uploadImages.add(url);
      }
    }

    if (action is AddNewPlaceAction) {
      try {
        final newPlace = Place(
          lat: action.place.lat,
          lng: action.place.lng,
          name: action.place.name,
          description: action.place.description,
          placeType: action.place.placeType,
          urls: uploadImages,
        );

        await _placeRepository.addNewPlace(newPlace);

        return store.dispatch(ResultAddNewPlaceAction());
      } catch (errMsg) {
        return store.dispatch(ErrorAddNewPlaceAction(errMsg.toString()));
      }
    }

    next(action);
  }
}
