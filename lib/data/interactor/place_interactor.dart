import 'dart:async';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

class PlaceInteractor {
  final PlaceRepository _placeRepository;

  PlaceInteractor(this._placeRepository);

  // Get a list of all places
  Future<List<Place>> getPlaces() async {
    return _placeRepository.getPlaces();
  }

  // Get a detailed description of the place
  Future<Place> getPlaceDetails({required int id}) async {
    return _placeRepository.getPlaceDetails(id: id);
  }

  // Get a list of favorite places
  Future<List<Place>> getFavoritePlaces() async {
    final places = await _placeRepository.getFavoritePlaces();
    return places;
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

  // Cache
  // Add place to device cache
  Future<void> addPlaceToCache(Place place) async {
    await _placeRepository.addPlaceToCache(place);
  }

  // Delete place from device cache
  Future<void> deletePlaceFromCache(Place place) async {
    await _placeRepository.deletePlaceFromCache(place);
  }

  // Favorites

  // Add place to list of favorite places
  Future<void> addPlaceToFavorites(Place place) async {
    await _placeRepository.addPlaceToFavorites(place);
  }

  // Add place from list of favorite places
  Future<void> deletePlaceFromFavorites(Place place) async {
    await _placeRepository.deletePlaceFromFavorites(place);
  }


}
