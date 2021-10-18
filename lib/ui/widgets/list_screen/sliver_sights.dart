import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widgets/list_screen/card/sight_card.dart';
import 'package:places/ui/widgets/list_screen/card/sight_landscape_widget.dart';
import 'package:places/ui/widgets/list_screen/card/sight_portrait_widget.dart';

class SliverSights extends StatelessWidget {
  final List<Place> places;

  const SliverSights({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SliverPadding(
      sliver: isPortrait
          ? SightPortraitWidget(places: places)
          : SightLandscapeWidget(places: places),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class SightPortraitWidget extends StatelessWidget {
  final List<Place> places;
  const SightPortraitWidget({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final place = places[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SightCard(place: place),
          );
        },
        childCount: places.length,
      ),
    );
  }
}

class SightLandscapeWidget extends StatelessWidget {
  final List<Place> places;
  const SightLandscapeWidget({Key? key, required this.places})
      : super(key: key);

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