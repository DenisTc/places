import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/sight_bottom_nav_bar.dart';
import 'package:places/ui/screens/sight_card_favorite.dart';

/// Screen for displaying planned and visited places
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: _FavoriteAppbar(),
        body: _FavoriteTabBarView(),
        bottomNavigationBar: SightBottomNavBar(),
      ),
    );
  }
}

class _FavoriteTabBarView extends StatelessWidget {
  const _FavoriteTabBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 28),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TabBarView(
        children: [
          if (mocks.isNotEmpty)
            Column(
              children: [
                FavoriteSightCard(mocks[0], false),
              ],
            )
          else
            _FavoritesEmpty(
              icon: iconRoute,
              title: 'Пусто',
              desc: 'Отмечайте понравившиеся\nместа и они появятся здесь.',
            ),
          if (mocks.isNotEmpty)
            Column(
              children: [
                FavoriteSightCard(mocks[2], true),
              ],
            )
          else
            _FavoritesEmpty(
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
                color: Color.fromRGBO(124, 126, 146, 0.56),
              ),
              SizedBox(height: 32),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(124, 126, 146, 0.56),
                ),
              ),
              SizedBox(height: 8),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(124, 126, 146, 0.56),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _FavoriteAppbar extends StatelessWidget with PreferredSizeWidget {
  final bool isDarkMode = false;

  const _FavoriteAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(116);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: isDarkMode ? darkColorPrimary : whiteSmoke,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 16,
          ),
          child: Theme(
            data: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: TabBar(
              tabs: [
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
              labelStyle: TextStyle(
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
