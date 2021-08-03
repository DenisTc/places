import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/icons.dart';

/// Custom bottom navigation bar.
class SightBottomNavBar extends StatelessWidget {
  const SightBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          currentIndex: 2,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(iconList, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(iconMap, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(iconFavoriteSolid, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(iconSettings, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
              label: '',
            ),
          ],
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Theme.of(context).primaryColorLight,
        )
      ],
    );
  }
}
