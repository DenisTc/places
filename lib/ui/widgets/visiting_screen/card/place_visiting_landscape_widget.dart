import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/visiting_screen/card/place_card_favorite.dart';

// Widget for displaying a list of places in horizontal orientation
class PlaceVisitingLandscapeWidget extends StatelessWidget {
  final List<Place> places;
  final bool visited;
  final Function(Place data, Place place, bool visited) moveItemInList;
  final Function(Place place, bool visited) removePlace;
  const PlaceVisitingLandscapeWidget({
    required this.places,
    required this.moveItemInList,
    required this.removePlace,
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
                  child: FavoritePlaceCard(
                    place: place,
                    visited: visited,
                    moveItemInList: moveItemInList,
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