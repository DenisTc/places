import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

class PlaceInteractor extends ChangeNotifier {
  final PlaceRepository _placeRepository = PlaceRepository();
  final StreamController<List<Place>> _listPlacesController =
      StreamController<List<Place>>.broadcast();

  Stream<List<Place>> get getStreamPlaces {
    _placeRepository.getPlaces().then(_listPlacesController.add);
    return _listPlacesController.stream;
  }

  PlaceInteractor();

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

  Future<bool> addNewPlace(Place place) async {
    try {
      await _placeRepository.addNewPlace(place);
      return true;
    } on Exception catch (_) {
      return false;
    }
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
    notifyListeners();
  }
}
