import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widgets/card/sight_card.dart';

class SliverSights extends StatelessWidget {
  const SliverSights({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList(
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
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}