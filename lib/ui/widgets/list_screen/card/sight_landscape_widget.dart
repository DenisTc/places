import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widgets/list_screen/card/sight_card.dart';

// Widget for displaying a list of favorites in landscape orientation
class SightLandscapeWidget extends StatelessWidget {
  const SightLandscapeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final sight = mocks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SightCard(sight: sight),
          );
        },
        childCount: mocks.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 36,
        childAspectRatio: 1.8,
      ),
    );
  }
}