import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/screen/sight_bottom_nav_bar.dart';
import 'package:places/ui/screen/sight_card_favorite.dart';

class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
    return TabBarView(
      children: [
        mocks.isNotEmpty
            ? FavoriteSightCard(mocks[0], false)
            : _FavoritesEmpty(
                icon: Icons.add_photo_alternate_outlined,
                title: 'Пусто',
                desc: 'Отмечайте понравившиеся\nместа и они появятся здесь.',
              ),
        mocks.isNotEmpty
            ? FavoriteSightCard(mocks[2], true)
            : _FavoritesEmpty(
                icon: Icons.earbuds_rounded,
                title: 'Пусто',
                desc: 'Завершите маршрут,\nчтобы место попало сюда.',
              ),
      ],
    );
  }
}

class _FavoritesEmpty extends StatelessWidget {
  final IconData icon;
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
              Icon(
                icon,
                size: 64,
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
            color: lightGrey,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 16,
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
              color: textColorPrimary,
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            unselectedLabelColor: textColorSecondary,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Избранное',
          style: TextStyle(
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: textColorPrimary,
          ),
        ),
      ),
    );
  }
}
