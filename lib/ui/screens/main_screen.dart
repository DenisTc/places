import 'package:flutter/material.dart';
import 'package:places/ui/screens/favorites_screen.dart';
import 'package:places/ui/screens/place_list_screen.dart';
import 'package:places/ui/screens/place_map_screen.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/widgets/place_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  final int? selectedTab;
  const MainScreen({Key? key, this.selectedTab}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int initialIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    initialIndex = widget.selectedTab ?? 0;
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: initialIndex,
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
    _tabController.index = initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          PlaceListScreen(),
          PlaceMapScreen(),
          FavoritesScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: PlaceBottomNavBar(
        currentIndex: initialIndex,
        onSelectTab: (index) {
          onSelectTab(index);
        },
      ),
    );
  }

  void onSelectTab(int index) {
    setState(() {
      initialIndex = index;
    });
  }
}
