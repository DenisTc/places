import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/visiting_screen/card/place_card_favorite.dart';
// import 'package:places/ui/widgets/visiting_screen/card/place_visiting_portrain_widget.dart';
import 'package:places/ui/widgets/visiting_screen/favorites_empty.dart';
import 'package:places/ui/widgets/visiting_screen/visiting_app_bar.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;

/// Screen for displaying planned and visited places
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

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
    BlocProvider.of<FavoritePlaceBloc>(context).add(LoadListFavoritePlaces());
    // final isPortrait =
    //     MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      margin: const EdgeInsets.only(top: 28),
      child: SafeArea(
        child: TabBarView(
          children: [
            // Favorites tab
            BlocBuilder<FavoritePlaceBloc, FavoritePlaceState>(
              builder: (context, state) {
                if (state is ListFavoritePlacesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ListFavoritePlacesLoaded &&
                    state.places.isNotEmpty) {
                  return PlaceVisitingPortrainWidget(
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

            // Places visited tab
            BlocBuilder<FavoritePlaceBloc, FavoritePlaceState>(
              builder: (context, state) {
                if (state is ListFavoritePlacesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ListFavoritePlacesLoaded &&
                    state.places.isNotEmpty) {
                  return PlaceVisitingPortrainWidget(
                    places: state.places,
                    visited: true,
                    moveItemInList: (data, place, places, visited) {
                      moveItemInList(data, place, state.places, visited);
                    },
                  );
                }

                return const FavoritesEmpty(
                  icon: iconAddCard,
                  title: 'Пусто',
                  desc: constants.textScrVisited,
                );
              },
            ),
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

class PlaceVisitingPortrainWidget extends StatelessWidget {
  final List<Place> places;
  final bool visited;
  final Function(
    Place data,
    Place place,
    List<Place> places,
    bool visited,
  ) moveItemInList;
  const PlaceVisitingPortrainWidget({
    required this.places,
    required this.moveItemInList,
    required this.visited,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: places.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isPortrait ? 1 : 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 36,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        final place = places[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: FavoritePlaceCard(
            place: place,
            visited: visited,
            moveItemInList: (data, place, visited) {
              moveItemInList(data, place, places, visited);
            },
          ),
        );
      },
    );
  }
}
