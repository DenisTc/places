import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/visiting_screen/favorites_empty.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_visiting_landscape_widget.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_visiting_portrain_widget.dart';
import 'package:places/ui/widgets/visiting_screen/visiting_app_bar.dart';

PlaceInteractor placeInteractor = PlaceInteractor();

/// Screen for displaying planned and visited places
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
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
  final Future<List<Place>> isVisited = placeInteractor.getVisitPlaces();
  final Future<List<Place>> notVisited = placeInteractor.getFavoritesPlaces();

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      margin: const EdgeInsets.only(top: 28),
      child: SafeArea(
        child: TabBarView(
          children: [
            FutureBuilder<List<Place>>(
              future: notVisited,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data!.isNotEmpty) {
                  return SightVisitingPortrainWidget(
                    places: snapshot.data!,
                    visited: false,
                    moveItemInList: (data, place, visited) {
                      moveItemInList(data, place, visited);
                    },
                    removeSight: (place, visited) {
                      removePlace(place, visited);
                    },
                  );
                } else {
                  return const FavoritesEmpty(
                    icon: iconRoute,
                    title: 'Пусто',
                    desc:
                        'Отмечайте понравившиеся\nместа и они появятся здесь.',
                  );
                }
              },
            ),
            // if (notVisited.isNotEmpty)
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

            FutureBuilder<List<Place>>(
              future: isVisited,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data!.isNotEmpty) {
                  return SightVisitingPortrainWidget(
                    places: snapshot.data!,
                    visited: true,
                    moveItemInList: (data, place, visited) {
                      moveItemInList(data, place, visited);
                    },
                    removeSight: (place, visited) {
                      removePlace(place, visited);
                    },
                  );
                } else {
                  return const FavoritesEmpty(
                    icon: iconRoute,
                    title: 'Пусто',
                    desc:
                        'Отмечайте понравившиеся\nместа и они появятся здесь.',
                  );
                }
              },
            ),

            // if (isVisited.isNotEmpty)
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

  void refresh() {
    setState(() {});
  }

  void moveItemInList(Place data, Place place, bool visited) {
    // setState(
    //   () {
    //     if (visited && isVisited.indexOf(data) != isVisited.indexOf(place)) {
    //       isVisited.remove(data);
    //       isVisited.insert(isVisited.indexOf(place), data);
    //     } else if (notVisited.indexOf(data) != notVisited.indexOf(place)) {
    //       notVisited.remove(data);
    //       notVisited.insert(notVisited.indexOf(place), data);
    //     }
    //   },
    // );
  }

  void removePlace(Place place, bool visited) {
    setState(() {
      if (visited) {
        //isVisited.remove(place);
        placeInteractor.removeFromVisit(place);
      } else {
        //notVisited.remove(place);
        placeInteractor.removeFromFavorites(place);
      }
    });
  }
}