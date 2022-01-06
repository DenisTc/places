import 'dart:async';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

class PlaceInteractor {
  final PlaceRepository _placeRepository;

  PlaceInteractor(this._placeRepository);

  // Get a list of all places
  Future<List<Place>> getPlaces([int? radius, String? category]) async {
    return _placeRepository.getPlaces();
  }

  // Get a detailed description of the place
  Future<Place> getPlaceDetails({required int id}) async {
    return _placeRepository.getPlaceDetails(id: id);
  }

  // Upload image on remote server
  Future<String> uploadImage(String image) async {
    return await _placeRepository.uploadImage(image);
  }

  // Add a new place
  Future<dynamic> addNewPlace(Place place) async {
    return _placeRepository.addNewPlace(place);
  }

  // Checking if the place is a favorite
  Future<bool> isFavoritePlace(Place place) async {
    return _placeRepository.isFavoritePlace(place);
  }

  // Change the favorite status for a place
  Future<void> toggleToFavorites(Place place) async {
    await _placeRepository.toggleToFavorites(place);
  }
}
