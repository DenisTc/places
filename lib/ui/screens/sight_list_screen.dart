import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/list_screen/add_sight_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_sights.dart';
import 'package:places/ui/widgets/network_exception.dart';
import 'package:provider/provider.dart';

class SightListScreen extends StatelessWidget {
  const SightListScreen({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final _placeInteractor = context.watch<PlaceInteractor>();
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverAppBarList(),
                StreamProvider<List<Place>>.value(
                  initialData: const [],
                  value: _placeInteractor.getStreamPlaces,
                  child: Consumer<List<Place>>(
                    builder: (context, place, _) {
                      if (place.isEmpty) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (place.isNotEmpty) {
                        return SliverSights(places: place);
                      }

                      return const SliverFillRemaining(
                        child: NetworkException(),
                      );
                    },
                  ),
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
