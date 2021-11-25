import 'package:flutter/material.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/sight_map_screen.dart';
import 'package:places/ui/screens/favorites_screen.dart';
import 'package:places/ui/widgets/sight_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int selectedTab = 0;
  late TabController _tabController;
  

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: selectedTab,
    );

    _tabController.addListener(() {
      onSelectTab(_tabController.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    _tabController.index = selectedTab;
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          SightListScreen(),
          SightMapScreen(),
          FavoritesScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: isPortrait
          ? SightBottomNavBar(
              currentIndex: selectedTab,
              onSelectTab: (index) {
                onSelectTab(index);
              },
            )
          : const SizedBox.shrink(),
    );
  }

  void onSelectTab(int index) {
    setState(() {
      selectedTab = index;
    });
  }
}
