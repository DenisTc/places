import 'package:flutter/material.dart';
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