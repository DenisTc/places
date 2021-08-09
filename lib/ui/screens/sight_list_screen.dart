import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/sight_bottom_nav_bar.dart';
import 'package:places/ui/screens/sight_card.dart';
import 'package:places/ui/widgets/list_screen/search_bar.dart';
import 'package:places/ui/widgets/list_screen/sight_app_bar.dart';

class SightListScreen extends StatefulWidget {
  @override
  createState() => new SightListScreenState();
}

class SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: SightAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SearchBar(),
            SizedBox(height: 22),
            SightCard(mocks[0]),
            const SizedBox(height: 16),
            SightCard(mocks[1]),
            const SizedBox(height: 16),
            SightCard(mocks[2]),
            const SizedBox(height: 16),
            SightCard(mocks[3])
          ],
        ),
      ),
      bottomNavigationBar: SightBottomNavBar(),
    );
  }
}