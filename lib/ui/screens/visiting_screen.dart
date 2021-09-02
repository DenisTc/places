import 'package:flutter/material.dart';
import 'package:places/domains/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/visiting_screen/favorites_empty.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_visiting_landscape_widget.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_visiting_portrain_widget.dart';
import 'package:places/ui/widgets/visiting_screen/visiting_app_bar.dart';

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
  List<Sight> isVisited = [...mocks];
  List<Sight> notVisited = [...mocks];

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      margin: const EdgeInsets.only(top: 28),
      child: SafeArea(
        child: TabBarView(
          children: [
            if (notVisited.isNotEmpty)
              isPortrait
                  ? SightVisitingPortrainWidget(
                      sights: notVisited,
                      visited: false,
                      moveItemInList: (data, sight, visited) {
                        moveItemInList(data, sight, visited);
                      },
                      removeSight: (sight, visited) {
                        removeSight(sight, visited);
                      }, 
                    )
                  : SightVisitingLandscapeWidget(
                      sights: notVisited,
                      visited: false,
                      moveItemInList: (data, sight, visited) {
                        moveItemInList(data, sight, visited);
                      },
                      removeSight: (sight, visited) {
                        removeSight(sight, visited);
                      },
                    )
            else
              const FavoritesEmpty(
                icon: iconRoute,
                title: 'Пусто',
                desc: 'Отмечайте понравившиеся\nместа и они появятся здесь.',
              ),
            if (isVisited.isNotEmpty)
              isPortrait
                  ? SightVisitingPortrainWidget(
                      sights: isVisited,
                      visited: true,
                      moveItemInList: (data, sight, visited) {
                        moveItemInList(data, sight, visited);
                      },
                      removeSight: (sight, visited) {
                        removeSight(sight, visited);
                      },
                    )
                  : SightVisitingLandscapeWidget(
                      sights: isVisited,
                      visited: true,
                      moveItemInList: (data, sight, visited) {
                        moveItemInList(data, sight, visited);
                      },
                      removeSight: (sight, visited) {
                        removeSight(sight, visited);
                      },
                    )
            else
              const FavoritesEmpty(
                icon: iconAddCard,
                title: 'Пусто',
                desc: 'Завершите маршрут,\nчтобы место попало сюда.',
              ),
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  void moveItemInList(Sight data, Sight sight, bool visited) {
    setState(
      () {
        if (visited && isVisited.indexOf(data) != isVisited.indexOf(sight)) {
          isVisited.remove(data);
          isVisited.insert(isVisited.indexOf(sight), data);
        } else if (notVisited.indexOf(data) != notVisited.indexOf(sight)) {
          notVisited.remove(data);
          notVisited.insert(notVisited.indexOf(sight), data);
        }
      },
    );
  }

  void removeSight(Sight sight, bool visited) {
    setState(() {
      if (visited) {
        isVisited.remove(sight);
      } else {
        notVisited.remove(sight);
      }
    });
  }
}
