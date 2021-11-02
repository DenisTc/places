import 'package:dio/dio.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/mapper/place_mapper.dart';
import 'package:places/domain/place.dart';

final api = ApiClient().client;

class PlaceRepository {
  final List<Place> favoritePlaces = [];
  final List<Place> visitPlaces = [];

  PlaceRepository();

  Future<List<Place>> getPlaces() async {
    final response = await api.get<List<dynamic>>(ApiConstants.placeUrl);

    return response.data!
        .map(
          (dynamic place) => PlaceMapper.toModel(
            PlaceDto.fromJson(place as Map<String, dynamic>),
          ),
        )
        .toList();
  }

  Future<Place> addNewPlace(Place place) async {
    final data = place;
    final response = await api.post<Map<String, dynamic>>(
      ApiConstants.placeUrl,
      data: data,
    );

    return PlaceMapper.toModel(PlaceDto.fromJson(response.data!));
  }

  Future<Place> getPlaceDetails({required int id}) async {
    final response =
        await api.get<Map<String, dynamic>>('${ApiConstants.placeUrl}/$id');

    return PlaceMapper.toModel(PlaceDto.fromJson(response.data!));
  }

  Future<Place?> deletePlace(int id) async {
    final response = await api.delete<Place>('${ApiConstants.placeUrl}/$id');
    return response.data;
  }

  Future<Place?> putPlace(int id) async {
    final response = await api.put<Place>('${ApiConstants.placeUrl}/$id');
    return response.data;
  }

  Future<List<Place>> getFavoritesPlaces() async {
    return favoritePlaces;
  }

  Future<List<Place>> getVisitPlaces() async {
    return visitPlaces;
  }

  bool isFavoritePlace(Place place) {
    return favoritePlaces.contains(place);
  }

  Future<void> addToFavorites(Place place) async {
    favoritePlaces.add(place);
  }

  Future<void> removeFromFavorites(Place place) async {
    favoritePlaces.remove(place);
  }

  Future<void> removeFromVisit(Place place) async {
    favoritePlaces.remove(place);
  }
}
