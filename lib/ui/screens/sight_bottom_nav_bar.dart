import 'package:flutter/material.dart';
import 'package:places/ui/colors.dart';

/// Creates a custom bottom navigation bar
class SightBottomNavBar extends StatelessWidget {
  const SightBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
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
    );
  }
}
