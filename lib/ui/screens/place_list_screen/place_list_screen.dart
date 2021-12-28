import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/place_list_screen/place_list_screen_wm.dart';
import 'package:places/ui/widgets/list_screen/add_place_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_places.dart';
import 'package:places/ui/widgets/network_exception.dart';
import 'package:relation/relation.dart';

class PlaceListScreen extends CoreMwwmWidget<PlaceListScreenWidgetModel> {
  const PlaceListScreen({
    WidgetModelBuilder? widgetModelBuilder,
  }) : super(widgetModelBuilder: PlaceListScreenWidgetModel.builder);

  @override
  WidgetState<CoreMwwmWidget<PlaceListScreenWidgetModel>,
          PlaceListScreenWidgetModel>
      createWidgetState() => _PlaceListScreenState();
}

class _PlaceListScreenState
    extends WidgetState<PlaceListScreen, PlaceListScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverAppBarList(),
                EntityStateBuilder<List<Place>>(
                  streamedState: wm.placeListState,
                  builder: (ctx, places) {
                    return SliverPlaces(
                      places: places,
                    );
                  },
                  loadingBuilder: (context, data) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      ),
                    );
                  },
                  loadingChild: const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    ),
                  ),
                  errorDataBuilder: (context, data, e) {
                    return const SliverFillRemaining(
                      child: NetworkException(),
                    );
                  },
                  errorChild: SliverFillRemaining(),
                ),
              ],
            ),
          ),
          const AddPlaceButton(),
        ],
      ),
    );
  }
}
