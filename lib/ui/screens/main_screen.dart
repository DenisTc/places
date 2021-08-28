import 'package:flutter/material.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/widgets/sight_bottom_nav_bar.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/sight_map_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedTab = 0;

  void onSelectTab(int index) {
    if (selectedTab == index) return;
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: const [
          SightListScreen(),
          SightMapScreen(),
          VisitingScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: SightBottomNavBar(
        currentIndex: selectedTab,
        onSelectTab: (index) {
          onSelectTab(index);
        },
      ),
    );
  }
}
