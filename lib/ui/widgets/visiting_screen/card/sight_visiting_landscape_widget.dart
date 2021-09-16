import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_card_favorite.dart';

// Widget for displaying a list of places in horizontal orientation
class SightVisitingLandscapeWidget extends StatelessWidget {
  final List<Place> places;
  final bool visited;
  final Function(Place data, Place place, bool visited) moveItemInList;
  final Function(Place place, bool visited) removeSight;
  const SightVisitingLandscapeWidget({
    Key? key,
    required this.places,
    required this.moveItemInList,
    required this.removeSight,
    required this.visited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final place = places[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
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
              childCount: places.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 36,
              childAspectRatio: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
