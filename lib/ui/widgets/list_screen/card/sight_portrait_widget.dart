import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widgets/list_screen/card/sight_card.dart';

// Widget for displaying a list of favorites in vertical orientation
class SightPortraitWidget extends StatelessWidget {
  const SightPortraitWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
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
    );
  }
}