import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/favorite_places/bloc/favorite_places_bloc.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_visiting_portrain_widget.dart';
import 'package:places/ui/widgets/visiting_screen/favorites_empty.dart';
import 'package:places/ui/widgets/visiting_screen/visiting_app_bar.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;

/// Screen for displaying planned and visited places
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: const VisitingAppbar(),
        body: const _FavoriteTabBarView(),
      ),
    );
  }
}

class _FavoriteTabBarView extends StatefulWidget {
  const _FavoriteTabBarView({
    Key? key,
  }) : super(key: key);

  @override
  __FavoriteTabBarViewState createState() => __FavoriteTabBarViewState();
}

class __FavoriteTabBarViewState extends State<_FavoriteTabBarView> {


  @override
  Widget build(BuildContext context) {
    // final isPortrait =
    //     MediaQuery.of(context).orientation == Orientation.portrait;
    BlocProvider.of<FavoritePlaceBloc>(context).add(LoadAllFavoritePlaces());
    BlocProvider.of<FavoritePlaceBloc>(context).add(LoadAllVisitedPlaces());
    return Container(
      margin: const EdgeInsets.only(top: 28),
      child: SafeArea(
        child: TabBarView(
          children: [
            BlocBuilder<FavoritePlaceBloc, FavoritePlaceState>(
              builder: (context, state) {
                if (state is FavoritePlacesListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is FavoritePlacesListLoaded &&
                    state.places.isNotEmpty) {
                  return SightVisitingPortrainWidget(
                    places: state.places,
                    visited: false,
                    moveItemInList: (data, place, places, visited) {
                      moveItemInList(data, place, state.places, visited);
                    },
                  );
                }

                return const FavoritesEmpty(
                  icon: iconAddCard,
                  title: 'Пусто',
                  desc: constants.textScrWantToVisit,
                );
              },
            ),

            // TODO: Customize the display of items in portrait and landscape orientation for the Favorites screen.
            // if (_notVisited.isNotEmpty)
            //   isPortrait
            //       ? SightVisitingPortrainWidget(
            //           places: notVisited,
            //           visited: false,
            //           moveItemInList: (data, place, visited) {
            //             moveItemInList(data, place, visited);
            //           },
            //           removeSight: (place, visited) {
            //             removePlace(place, visited);
            //           },
            //         )
            //       : SightVisitingLandscapeWidget(
            //           places: notVisited,
            //           visited: false,
            //           moveItemInList: (data, place, visited) {
            //             moveItemInList(data, place, visited);
            //           },
            //           removeSight: (place, visited) {
            //             removePlace(place, visited);
            //           },
            //         )
            // else
            //   const FavoritesEmpty(
            //     icon: iconRoute,
            //     title: 'Пусто',
            //     desc: 'Отмечайте понравившиеся\nместа и они появятся здесь.',
            //   ),

            BlocBuilder<FavoritePlaceBloc, FavoritePlaceState>(
              builder: (context, state) {
                if (state is VisitedPlacesListLoaded &&
                    state.places.isNotEmpty) {
                  return SightVisitingPortrainWidget(
                    places: state.places,
                    visited: true,
                    moveItemInList: (data, place, places, visited) {
                      moveItemInList(data, place, state.places, visited);
                    },
                  );
                }

                return const FavoritesEmpty(
                  icon: iconRoute,
                  title: 'Пусто',
                  desc: constants.textScrVisited,
                );
              },
            ),

            // TODO: Customize the display of items in portrait and landscape orientation for the visited places screen.
            // if (_isVisited.isNotEmpty)
            //   isPortrait
            //       ? SightVisitingPortrainWidget(
            //           places: isVisited,
            //           visited: true,
            //           moveItemInList: (data, place, visited) {
            //             moveItemInList(data, place, visited);
            //           },
            //           removeSight: (place, visited) {
            //             removePlace(place, visited);
            //           },
            //         )
            //       : SightVisitingLandscapeWidget(
            //           places: isVisited,
            //           visited: true,
            //           moveItemInList: (data, place, visited) {
            //             moveItemInList(data, place, visited);
            //           },
            //           removeSight: (place, visited) {
            //             removePlace(place, visited);
            //           },
            //         )
            // else
            // const FavoritesEmpty(
            //   icon: iconAddCard,
            //   title: 'Пусто',
            //   desc: 'Завершите маршрут,\nчтобы место попало сюда.',
            // ),
          ],
        ),
      ),
    );
  }

  void moveItemInList(
    Place data,
    Place place,
    List<Place> placeList,
    bool visited,
  ) {
    setState(
      () {
        if (placeList.indexOf(data) != placeList.indexOf(place)) {
          placeList.remove(data);
          placeList.insert(placeList.indexOf(place), data);
        }
      },
    );
  }
}
