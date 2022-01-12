import 'package:flutter/material.dart';
import 'package:places/ui/screens/favorites_screen.dart';
import 'package:places/ui/screens/place_list_screen.dart';
import 'package:places/ui/screens/place_map_screen.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/widgets/place_bottom_nav_bar.dart';

class Home extends StatefulWidget {
  final int? selectedTab;
  const Home({Key? key, this.selectedTab}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  static List<Widget> pages = [
    PlaceListScreen(),
    PlaceMapScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  late TabController _tabController;

  int initialIndex = 0;

  @override
  void initState() {
    initialIndex = widget.selectedTab ?? 0;

    _tabController = TabController(
      vsync: this,
      length: pages.length,
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
        children: pages,
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
