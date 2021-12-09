import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/redux/action/filtered_places_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/filtered_places_state.dart';
import 'package:places/ui/widgets/list_screen/add_sight_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_sights.dart';
import 'package:places/ui/widgets/network_exception.dart';

class SightListScreen extends StatelessWidget {
  const SightListScreen({Key? key}) : super(key: key);

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
                StoreConnector<AppState, FilteredPlacesState>(
                  onInit: (store) {
                    store.dispatch(LoadFilteredPlacesAction());
                  },
                  converter: (store) {
                    return store.state.filteredPlacesState;
                  },
                  builder: (BuildContext context, FilteredPlacesState vm) {
                    if (vm is FilteredPlacesLoadingState) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        ),
                      );
                    }

                    if (vm is FilteredPlacesErrorState) {
                      return const SliverFillRemaining(
                        child: NetworkException(),
                      );
                    }

                    if (vm is FilteredPlacesDataState) {
                      return SliverSights(
                        places: vm.places,
                      );
                    }

                    return const SliverFillRemaining(
                      child: SizedBox.shrink(),
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
