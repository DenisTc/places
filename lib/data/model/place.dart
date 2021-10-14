// Map categories = <String, String>{
//   'other': 'достопримечательность',
//   'museum': 'музей',
//   'monument': 'памятник',
//   'theatre': 'театр',
//   'park': 'парк',
//   'hotel': 'отель',
//   'cafe': 'кафе',
//   'restaurant': 'ресторан',
// };

class Place {
  final int id;
  final double? lat;
  final double? lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  Place({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        lat = (json['lat'] as num?)?.toDouble(),
        lng = (json['lng'] as num?)?.toDouble(),
        name = json['name'] as String,
        urls = List<String>.from(
          json['urls'] as List<dynamic>,
        ),
        placeType = json['placeType'] as String,
        // placeType = (categories[json['placeType']] ?? json['placeType']) as String,
        description = json['description'] as String;
}
