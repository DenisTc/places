import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/data/blocs/geolocation/geolocation_bloc.dart';
import 'package:places/ui/widgets/custom_loader_widget.dart';
import 'package:places/ui/widgets/list_screen/add_place_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_places.dart';
import 'package:places/ui/widgets/network_exception.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

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
                BlocBuilder<GeolocationBloc, GeolocationState>(
                  builder: (context, state) {
                    if (state is LoadGeolocationSuccess) {
                      context
                          .read<FilteredPlacesBloc>()
                          .add(const LoadFilteredPlaces());
                    }

                    if (state is LoadGeolocationError) {
                      context
                          .read<FilteredPlacesBloc>()
                          .add(const LoadFilteredPlaces(defaultGeo: true));
                    }

                    if (state is LoadGeolocationInProgress) {
                      return const SliverFillRemaining(
                        child: CustomLoaderWidget(),
                      );
                    }

                    return BlocBuilder<FilteredPlacesBloc, FilteredPlacesState>(
                      buildWhen: (context, state) {
                        return state is LoadFilteredPlacesSuccess ||
                            state is LoadFilteredPlacesError;
                      },
                      builder: (context, state) {
                        if (state is LoadFilteredPlacesInProgress) {
                          return const SliverFillRemaining(
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
                    );
                  },
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 16,
            child: AddPlaceButton(),
          ),
        ],
      ),
    );
  }
}
