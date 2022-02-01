import 'package:places/domain/place.dart';
import 'package:share_plus/share_plus.dart';

void sharePlace(Place place) {
    final placeName = place.name;
    final decription = (place.description.length > 180)
        ? '${place.description.substring(0, 180)}...'
        : place.description;
    final mapLink =
        'https://yandex.ru/maps/?whatshere[point]=${place.lng},${place.lat}&whatshere[zoom]=17';

    Share.share(
      '${placeName}\n${decription}\n${mapLink}',
    );
  }