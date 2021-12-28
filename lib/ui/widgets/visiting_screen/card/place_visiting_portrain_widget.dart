import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/visiting_screen/card/place_card_favorite.dart';

// Widget for displaying a list of places in a vertical orientation
class PlaceVisitingPortrainWidget extends StatelessWidget {
  final List<Place> places;
  final bool visited;
  final Function(
    Place data,
    Place place,
    List<Place> places,
    bool visited,
  ) moveItemInList;
  const PlaceVisitingPortrainWidget({
    required this.places,
    required this.moveItemInList,
    required this.visited,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: FavoritePlaceCard(
            place: place,
            visited: visited,
            moveItemInList: (data, place, visited) {
              moveItemInList(data, place, places, visited);
            },
          ),
        );
      },
    );
  }
}