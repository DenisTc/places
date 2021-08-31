import 'package:flutter/material.dart';
import 'package:places/domains/sight.dart';
import 'package:places/ui/widgets/visiting_screen/sight_card_favorite.dart';

// Widget for displaying a list of places in horizontal orientation
class SightVisitingLandscapeWidget extends StatefulWidget {
  final List<Sight> sights;
  final bool visited;
  final Function(Sight data, Sight sight, bool visited) moveItemInList;
  final Function(Sight sight, bool visited) removeSight;
  const SightVisitingLandscapeWidget({
    Key? key,
    required this.sights,
    required this.moveItemInList,
    required this.removeSight,
    required this.visited,
  }) : super(key: key);

  @override
  _SightVisitingLandscapeWidgetState createState() =>
      _SightVisitingLandscapeWidgetState();
}

class _SightVisitingLandscapeWidgetState
    extends State<SightVisitingLandscapeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final sight = widget.sights[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FavoriteSightCard(
                    sight: sight,
                    visited: widget.visited,
                    moveItemInList: (data, sight, visited) {
                      widget.moveItemInList(data, sight, visited);
                    },
                    removeSight: (sight, visited) {
                      widget.removeSight(sight, visited);
                    },
                  ),
                );
              },
              childCount: widget.sights.length,
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
