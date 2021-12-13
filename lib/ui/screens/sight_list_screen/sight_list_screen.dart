import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/sight_list_screen/sight_list_screen_wm.dart';
import 'package:places/ui/widgets/list_screen/add_sight_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_sights.dart';
import 'package:places/ui/widgets/network_exception.dart';
import 'package:relation/relation.dart';

class SightListScreen extends CoreMwwmWidget<SightListScreenWidgetModel> {
  const SightListScreen({
    WidgetModelBuilder? widgetModelBuilder,
  }) : super(widgetModelBuilder: SightListScreenWidgetModel.builder);

  @override
  WidgetState<CoreMwwmWidget<SightListScreenWidgetModel>,
          SightListScreenWidgetModel>
      createWidgetState() => _SightListScreenState();
}

class _SightListScreenState
    extends WidgetState<SightListScreen, SightListScreenWidgetModel> {
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
                    return SliverSights(
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
          const AddSightButton(),
        ],
      ),
    );
  }
}
