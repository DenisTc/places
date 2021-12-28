import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/list_screen/card/place_card.dart';

class SliverPlaces extends StatelessWidget {
  final List<Place> places;

  const SliverPlaces({
    required this.places,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SliverPadding(
      sliver: isPortrait
          ? PlacePortraitWidget(places: places)
          : PlaceLandscapeWidget(places: places),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class PlacePortraitWidget extends StatelessWidget {
  final List<Place> places;
  const PlacePortraitWidget({
    required this.places,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final place = places[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 18),
            child: PlaceCard(place: place),
          );
        },
        childCount: places.length,
      ),
    );
  }
}

class PlaceLandscapeWidget extends StatelessWidget {
  final List<Place> places;
  const PlaceLandscapeWidget({
    required this.places,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final place = places[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PlaceCard(place: place),
          );
        },
        childCount: places.length,
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
