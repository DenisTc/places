import 'dart:async';

import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

class PlaceInteractor {
  final PlaceRepository _placeRepository;
  final StreamController<List<Place>> _listPlacesController =
      StreamController<List<Place>>.broadcast();

  Stream<List<Place>> get getStreamPlaces {
    _placeRepository.getPlaces().then(_listPlacesController.add);
    return _listPlacesController.stream;
  }

  PlaceInteractor(this._placeRepository);

  void addErrorToPlacesController(Object error) {
    _listPlacesController.addError(error);
  }

  // Methods for working with a remote repository

  Future<List<Place>> getPlaces([
    int? radius,
    String? category,
  ]) async {
    return _placeRepository.getPlaces();
  }

  Future<Place> getPlaceDetails({required int id}) async {
    return _placeRepository.getPlaceDetails(id: id);
  }

  Stream<Place> addNewPlace(Place place) async* {
    _placeRepository.addNewPlace(place);
  }

  /// Methods for working with favorites places

  Future<List<Place>> getFavoritesPlaces() async {
    return _placeRepository.getFavoritesPlaces();
  }

  Stream<bool> isFavoritePlace(Place place) async* {
    yield _placeRepository.isFavoritePlace(place);
  }

  Future<void> toggleInFavorites(Place place) async {
    await _placeRepository.toggleInFavorites(place);
    // notifyListeners();
  }
}
