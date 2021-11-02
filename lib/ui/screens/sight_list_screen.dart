import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/list_screen/add_sight_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_sights.dart';
import 'package:places/ui/widgets/network_exception.dart';
import 'package:provider/provider.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  SightListScreenState createState() => SightListScreenState();
}

class SightListScreenState extends State<SightListScreen> {
  late Stream<List<Place>> places;

  @override
  Widget build(BuildContext context) {
    final placeInteractor = context.read<PlaceInteractor>();
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverAppBarList(),
                StreamBuilder<List<Place>>(
                  stream: placeInteractor.getStreamPlaces,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (snapshot.hasData && !snapshot.hasError) {
                      return SliverSights(places: snapshot.data!);
                    }

                    return const SliverFillRemaining(
                      child: NetworkException(),
                    );
                  },
                ),
              ],
            ),
          ),
          const AddSightButton(),
        ],
      ),
    );
  }
}
