import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

class PlaceInteractor {
  final PlaceRepository _placeRepository = PlaceRepository();

  Future<List<Place>> getPlaces([int? radius, String? category]) async {
    return _placeRepository.getPlaces();
  }

  Future<Place> getPlaceDetails({required int id}) async {
    return _placeRepository.getPlaceDetails(id: id);
  }

  Future<List<Place>> getFavoritesPlaces() async {
    return _placeRepository.getFavoritesPlaces();
  }

  Future<bool> addToFavorites(Place place) async {
    try {
      await PlaceRepository.addToFavorites(place);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> removeFromFavorites(Place place) async {
    try {
      
      await _placeRepository.removeFromFavorites(place);
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

  Future<List<Place>> getVisitPlaces() async {
    return _placeRepository.getVisitPlaces();
  }

  Future<List<Place>> getFavoritePlaces() async {
    return _placeRepository.getFavoritesPlaces();
  }

  Future<bool> addToVisitingPlaces(Place place) async {
    try {
      //await _placeRepository.addToVisitingPlaces(place);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> addNewPlace(Place place) async {
    try {
      await _placeRepository.addNewPlace(place);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}