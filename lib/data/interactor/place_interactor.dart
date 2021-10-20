import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

class PlaceInteractor {
  final PlaceRepository _placeRepository;

  PlaceInteractor(this._placeRepository);

  Future<List<Place>> getPlaces([int? radius, String? category]) async {
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

  //Favorite places methods

  Future<List<Place>> getFavoritesPlaces() async {
    return _placeRepository.getFavoritesPlaces();
  }

  Future<void> addToFavorites(Place place) async {
    await _placeRepository.addToFavorites(place);
  }

  Future<void> removeFromFavorites(Place place) async {
    await _placeRepository.removeFromFavorites(place);
  }

  Future<bool> isFavoritePlace(Place place) async {
    return _placeRepository.isFavoritePlace(place);
  }

  //Visited places methods

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

  Future<bool> addToVisitingPlaces(Place place) async {
    try {
      //TODO: It is necessary to implement a method for adding a place to the list of visited places.
      //await _placeRepository.addToVisitingPlaces(place);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
