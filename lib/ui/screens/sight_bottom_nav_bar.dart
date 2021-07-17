import 'package:flutter/material.dart';

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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.list_alt_sharp,
                ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
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
