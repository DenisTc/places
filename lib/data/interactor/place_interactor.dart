import 'dart:async';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/place_with_date.dart';

class PlaceInteractor {
  final PlaceRepository _placeRepository;

  PlaceInteractor(this._placeRepository);

  // Get a list of all places
  Future<List<Place>> getPlaces() async => await _placeRepository.getPlaces();

  // Get a detailed description of the place
  Future<Place> getPlaceDetails({required int id}) async =>
      await _placeRepository.getPlaceDetails(id: id);

  // Get a list of favorite places
  Future<List<Place>> getFavoritePlaces() async =>
      await _placeRepository.getFavoritePlaces();

  // Upload image on remote server
  Future<String> uploadImage(String image) async =>
      await _placeRepository.uploadImage(image);

  // Add a new place
  Future<dynamic> addNewPlace(Place place) async =>
      await _placeRepository.addNewPlace(place);

  // Checking if the place is a favorite
  Future<bool> isFavoritePlace(Place place) async =>
      await _placeRepository.isFavoritePlace(place);

  // Cache

  // Add place to device cache
  Future<void> addPlaceToCache(Place place) async =>
      await _placeRepository.addPlaceToCache(place);

  // Delete place from device cache
  Future<void> deletePlaceFromCache(Place place) async =>
      await _placeRepository.deletePlaceFromCache(place);

  // Favorites

  // Add place to list of favorite places
  Future<void> addPlaceToFavorites(Place place) async =>
      await _placeRepository.addPlaceToFavorites(place);

  // Add place from list of favorite places
  Future<void> deletePlaceFromFavorites(Place place) async =>
      await _placeRepository.deletePlaceFromFavorites(place);

  // Visited

  // Get a list of places with a specified date of visit
  Future<List<PlaceWithDate>> getVisitedPlaces() async =>
      await _placeRepository.getVisitedPlaces();

  // Add a place to the list with a specified date of visit
  Future<void> addPlaceToVisitedList({
    required int id,
    required DateTime date,
  }) async =>
      await _placeRepository.addPlaceToVisitedList(id: id, date: date);
}
