import 'package:flutter/material.dart';
import 'package:places/domains/sight.dart';
import 'package:places/ui/widgets/visiting_screen/sight_card_favorite.dart';

// Widget for displaying a list of places in a vertical orientation
class SightVisitingPortrainWidget extends StatelessWidget {
  final List<Sight> sights;
  final bool visited;
  final Function(Sight data, Sight sight, bool visited) moveItemInList;
  final Function(Sight sight, bool visited) removeSight;
  const SightVisitingPortrainWidget({
    Key? key,
    required this.sights,
    required this.moveItemInList,
    required this.removeSight,
    required this.visited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: sights.length,
      itemBuilder: (context, index) {
        final sight = sights[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: FavoriteSightCard(
            sight: sight,
            visited: visited,
            moveItemInList: (data, sight, visited) {
              moveItemInList(data, sight, visited);
            },
            removeSight: (sight, visited) {
              removeSight(sight, visited);
            },
          ),
        );
      },
    );
  }
}
