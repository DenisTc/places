import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_card_favorite.dart';

// Widget for displaying a list of places in a vertical orientation
class SightVisitingPortrainWidget extends StatelessWidget {
  final List<Place> places;
  final bool visited;
  final Function(Place data, Place place, bool visited) moveItemInList;
  final Function(Place place, bool visited) removeSight;
  const SightVisitingPortrainWidget({
    Key? key,
    required this.places,
    required this.moveItemInList,
    required this.removeSight,
    required this.visited,
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
          child: FavoriteSightCard(
            place: place,
            visited: visited,
            moveItemInList: (data, place, visited) {
              moveItemInList(data, place, visited);
            },
            removeSight: (place, visited) {
              removeSight(place, visited);
            },
          ),
        );
      },
    );
  }
}