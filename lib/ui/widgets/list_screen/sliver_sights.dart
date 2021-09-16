import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widgets/list_screen/card/sight_card.dart';
import 'package:places/ui/widgets/list_screen/card/sight_landscape_widget.dart';
import 'package:places/ui/widgets/list_screen/card/sight_portrait_widget.dart';

class SliverSights extends StatelessWidget {
  const SliverSights({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return SliverPadding(
      sliver: isPortrait
          ? const SightPortraitWidget()
          : const SightLandscapeWidget(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class SightPortraitWidget extends StatelessWidget {
  const SightPortraitWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final place = mocks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SightCard(place: place),
          );
        },
        childCount: mocks.length,
      ),
    );
  }
}

class SightLandscapeWidget extends StatelessWidget {
  const SightLandscapeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final place = mocks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SightCard(place: place),
          );
        },
        childCount: mocks.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 36,
        childAspectRatio: 2,
      ),
    );
  }
}
