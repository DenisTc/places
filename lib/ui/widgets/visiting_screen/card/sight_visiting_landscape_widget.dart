import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_card_favorite.dart';

// Widget for displaying a list of places in horizontal orientation
class SightVisitingLandscapeWidget extends StatelessWidget {
  final List<Place> places;
  final bool visited;
  final Function(Place data, Place place, bool visited) moveItemInList;
  final Function(Place place, bool visited) removeSight;
  const SightVisitingLandscapeWidget({
    required this.places,
    required this.moveItemInList,
    required this.removeSight,
    required this.visited,
    Key? key,
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
                    moveItemInList: moveItemInList,
                    removeSight: removeSight,
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