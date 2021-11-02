import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_visiting_portrain_widget.dart';
import 'package:places/ui/widgets/visiting_screen/favorites_empty.dart';
import 'package:places/ui/widgets/visiting_screen/visiting_app_bar.dart';
import 'package:provider/provider.dart';

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
  late PlaceInteractor _placeInteractor;
  late Future<List<Place>> _isVisited;
  late Future<List<Place>> _notVisited;

  @override
  void initState() {
    _placeInteractor = context.read<PlaceInteractor>();
    _isVisited = _placeInteractor.getVisitPlaces();
    _notVisited = _placeInteractor.getFavoritesPlaces();
    super.initState();
  }

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
              future: _notVisited,
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
            // TODO(Denis): Customize the display of items in portrait and landscape orientation for the Favorites screen.
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

            FutureBuilder<List<Place>>(
              future: _isVisited,
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

            // TODO(Denis): Customize the display of items in portrait and landscape orientation for the visited places screen.
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

  void refresh() {
    setState(() {});
  }

  void moveItemInList(Place data, Place place, bool visited) {
    //TODO(Denis): Configure the logic of interaction with the card.
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
        // placeInteractor.removeFromVisit(place);
      } else {
        //notVisited.remove(place);
        // placeInteractor.removeFromFavorites(place);
      }
    });
  }
}
