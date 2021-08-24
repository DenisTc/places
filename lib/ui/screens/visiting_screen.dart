import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/sight_bottom_nav_bar.dart';
import 'package:places/ui/widgets/card/sight_card_favorite/sight_card_favorite.dart';

/// Screen for displaying planned and visited places
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: const _FavoriteAppbar(),
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

  void refresh() {
    setState(() {});
  }

  void moveItemInList(Sight data, Sight sight, bool visited) {
    setState(() {
      if (visited) {
        isVisited.remove(data);
        isVisited.insert(isVisited.indexOf(sight), data);
      } else {
        notVisited.remove(data);
        notVisited.insert(notVisited.indexOf(sight), data);
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 28),
      child: TabBarView(
        children: [
          if (notVisited.isNotEmpty)
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              itemCount: notVisited.length,
              itemBuilder: (BuildContext context, int index) {
                final sight = notVisited[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: FavoriteSightCard(
                    sight: sight,
                    visited: false,
                    moveItemInList: (data, sight, visited) {
                      moveItemInList(data, sight, visited);
                    },
                    removeSight: (sight, visited) {
                      removeSight(sight, visited);
                    },
                  ),
                );
              },
            )
          else
            const _FavoritesEmpty(
              icon: iconRoute,
              title: 'Пусто',
              desc: 'Отмечайте понравившиеся\nместа и они появятся здесь.',
            ),
          if (isVisited.isNotEmpty)
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              itemCount: isVisited.length,
              itemBuilder: (BuildContext context, int index) {
                final sight = isVisited[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: FavoriteSightCard(
                    sight: sight,
                    visited: true,
                    moveItemInList: (data, sight, visited) {
                      moveItemInList(data, sight, visited);
                    },
                    removeSight: (notVisited, sight) {
                      removeSight(notVisited, sight);
                    },
                  ),
                );
              },
            )
          else
            const _FavoritesEmpty(
              icon: iconAddCard,
              title: 'Пусто',
              desc: 'Завершите маршрут,\nчтобы место попало сюда.',
            ),
        ],
      ),
    );
  }
}

class _FavoritesEmpty extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;

  const _FavoritesEmpty({
    Key? key,
    required this.icon,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 253.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: 64,
                width: 64,
                color: const Color.fromRGBO(124, 126, 146, 0.56),
              ),
              const SizedBox(height: 32),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(124, 126, 146, 0.56),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(124, 126, 146, 0.56),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FavoriteAppbar extends StatelessWidget with PreferredSizeWidget {
  final bool isDarkMode = false;

  @override
  Size get preferredSize => const Size.fromHeight(116);

  const _FavoriteAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: isDarkMode ? darkColorPrimary : whiteSmoke,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 16,
          ),
          child: Theme(
            data: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: TabBar(
              tabs: const [
                Tab(
                  text: 'Хочу посетить',
                ),
                Tab(
                  text: 'Посетил',
                ),
              ],
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: isDarkMode ? Colors.white : textColorPrimary,
              ),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              unselectedLabelColor: textColorSecondary.withOpacity(0.56),
              labelColor: isDarkMode ? textColorPrimary : Colors.white,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Избранное',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}
