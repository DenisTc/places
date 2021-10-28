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

  void dispose() {
    _listPlacesController.close();
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

  Future<bool> addNewPlace(Place place) async {
    try {
      await _placeRepository.addNewPlace(place);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  // Methods for working with favorites places

  Future<List<Place>> getFavoritesPlaces() async {
    return _placeRepository.getFavoritesPlaces();
  }

  Stream<bool> isFavoritePlace(Place place) async* {
    yield _placeRepository.isFavoritePlace(place);
  }

  Future<void> addToFavorites(Place place) async {
    await _placeRepository.addToFavorites(place);
  }

  Future<void> removeFromFavorites(Place place) async {
    await _placeRepository.removeFromFavorites(place);
  }

  // Methods for working with visited places

  Future<List<Place>> getVisitPlaces() async {
    return _placeRepository.getVisitPlaces();
  }

  Future<bool> addToVisitingPlaces(Place place) async {
    try {
      //TODO: It is necessary to implement a method for adding a place to the list of visited places.
      //await _placeRepository.addToVisitingPlaces(place);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> removeFromVisit(Place place) async {
    try {
      await _placeRepository.removeFromVisit(place);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
