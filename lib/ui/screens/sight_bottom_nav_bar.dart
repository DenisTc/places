import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/icons.dart';

/// Custom bottom navigation bar.
class SightBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int index) onSelectTab;
  
  const SightBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onSelectTab,
  }) : super(key: key);

  @override
  _SightBottomNavBarState createState() => _SightBottomNavBarState();
}

class _SightBottomNavBarState extends State<SightBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              widget.onSelectTab(index);
            });
          },
          currentIndex: widget.currentIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(iconList,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(iconMap,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(iconFavoriteSolid,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(iconSettings,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor),
              label: '',
            ),
          ],
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Theme.of(context).primaryColorLight,
        ),
      ],
    );
  }
}
