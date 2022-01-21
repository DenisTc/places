import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/ui/widgets/custom_loader_widget.dart';
import 'package:places/ui/widgets/list_screen/add_place_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_places.dart';
import 'package:places/ui/widgets/network_exception.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FilteredPlacesBloc>(context).add(LoadFilteredPlaces());

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
                  buildWhen: (context, state) {
                    return state is LoadFilteredPlacesSuccess;
                  },
                  builder: (context, state) {
                    if (state is LoadFilteredPlacesInProgress) {
                      return SliverFillRemaining(
                        child: CustomLoaderWidget(),
                      );
                    }

                    if (state is LoadFilteredPlacesSuccess) {
                      return SliverPlaces(
                        places: state.places,
                      );
                    }

                    if (state is LoadFilteredPlacesError) {
                      return const SliverFillRemaining(
                        child: NetworkException(),
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
          const Positioned(
            bottom: 16,
            child:  AddPlaceButton(),
          ),
        ],
      ),
    );
  }
}
