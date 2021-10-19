import 'package:places/data/model/place_dto.dart';
import 'package:places/domain/place.dart';

class PlaceMapper {
  static Place toModel(PlaceDto placeDto) {
    return Place(
      id: placeDto.id,
      lat: placeDto.lat,
      lng: placeDto.lng,
      name: placeDto.name,
      placeType: placeDto.placeType,
      description: placeDto.description,
      urls: placeDto.urls,
    );
  }
}