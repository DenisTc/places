import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/icons.dart';

// Custom bottom navigation bar
class PlaceBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int index) onSelectTab;

  const PlaceBottomNavBar({
    required this.currentIndex,
    required this.onSelectTab,
    Key? key,
  }) : super(key: key);

  @override
  _PlaceBottomNavBarState createState() => _PlaceBottomNavBarState();
}

class _PlaceBottomNavBarState extends State<PlaceBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return isPortrait
        ? Stack(
            children: [
              BottomNavigationBar(
                onTap: (index) {
                  setState(() {
                    widget.onSelectTab(index);
                  });
                },
                currentIndex: widget.currentIndex,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                unselectedItemColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      iconList,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                    ),
                    activeIcon: SvgPicture.asset(
                      iconListSelected,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      iconMap,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                    ),
                    activeIcon: SvgPicture.asset(
                      iconMapSelected,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      iconFavorite,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                    ),
                    activeIcon: SvgPicture.asset(
                      iconFavoriteSelected,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      iconSettings,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                    ),
                    activeIcon: SvgPicture.asset(
                      iconSettingsSelected,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor,
                    ),
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
          )
        : const SizedBox.shrink();
  }
}
