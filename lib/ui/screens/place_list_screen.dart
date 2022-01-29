import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/data/blocs/geolocation/geolocation_bloc.dart';
import 'package:places/ui/widgets/custom_loader_widget.dart';
import 'package:places/ui/widgets/list_screen/add_place_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_places.dart';
import 'package:places/ui/widgets/network_exception.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlaceListScreen extends StatefulWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    context.read<FilteredPlacesBloc>().add(const LoadFilteredPlaces());
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            CustomScrollView(
              slivers: [
                const SliverAppBarList(),
                SliverFillRemaining(
                  child: SmartRefresher(
                    controller: _refreshController,
                    header: CustomHeader(
                      refreshStyle: RefreshStyle.Behind,
                      onOffsetChange: (offset) {},
                      builder: (c, m) {
                        if (m == RefreshStatus.idle) {
                          return Image(
                            image: AssetImage(constants.pathLoader),
                            height: 30,
                            width: 30,
                          );
                        }

                        return CustomLoaderWidget();
                      },
                    ),
                    onRefresh: _onRefresh,
                    child: CustomScrollView(
                      slivers: [
                        BlocBuilder<GeolocationBloc, GeolocationState>(
                          builder: (context, state) {
                            if (state is LoadGeolocationSuccess) {
                              context
                                  .read<FilteredPlacesBloc>()
                                  .add(const LoadFilteredPlaces());
                            }

                            if (state is LoadGeolocationError) {
                              context.read<FilteredPlacesBloc>().add(
                                  const LoadFilteredPlaces(defaultGeo: true));
                            }

                            if (state is LoadGeolocationInProgress) {
                              return const SliverFillRemaining(
                                child: CustomLoaderWidget(),
                              );
                            }

                            return BlocBuilder<FilteredPlacesBloc,
                                FilteredPlacesState>(
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
                ),
              ],
            ),
            const Positioned(
              bottom: 16,
              child: AddPlaceButton(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
