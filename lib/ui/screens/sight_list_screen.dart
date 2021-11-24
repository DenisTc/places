import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:places/data/blocs/filtered_places/filtered_places_event.dart';
import 'package:places/data/blocs/filtered_places/filtered_places_state.dart';
import 'package:places/data/blocs/filtered_places/filtered_places_bloc.dart';
import 'package:places/data/blocs/theme/bloc/theme_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/store/place_list/place_list_store.dart';
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
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FilteredPlacesBloc>(context).add(FilteredPlacesLoad());
  }

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
                BlocBuilder<FilteredPlacesBloc, FilteredPlacesState>(
                  builder: (context, state) {
                    if (state is FilteredPlacesLoadInProgress) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state is FilteredPlacesLoadSuccess) {
                      return SliverSights(
                        places: state.places,
                      );
                    }

                    // if (state is FilteredPlacesLoadError) {
                      return const SliverFillRemaining(
                        child: NetworkException(),
                      );
                    // }

                    // return const SliverFillRemaining(
                    //     child: NetworkException(),
                    //   );
                    // return Center(child: Text('Something gona wrong'));
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
