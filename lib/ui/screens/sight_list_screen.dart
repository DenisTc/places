import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/sight_bottom_nav_bar.dart';
import 'package:places/ui/screens/sight_card.dart';
import 'package:places/ui/widgets/main_list_screen/search_bar.dart';
import 'package:places/ui/widgets/main_list_screen/sight_app_bar.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({ Key? key }) : super(key: key);

  @override
  SightListScreenState createState() => SightListScreenState();
}

class SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: const SightAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16,
              top: 70,
              right: 16,
            ),
            child: Column(
              children: [
                SightCard(mocks[0]),
                const SizedBox(height: 16),
                SightCard(mocks[1]),
                const SizedBox(height: 16),
                SightCard(mocks[2]),
                const SizedBox(height: 16),
                SightCard(mocks[3]),
              ],
            ),
          ),
          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 0,
                right: 16,
                bottom: 10,
              ),
              child: SearchBar(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SightBottomNavBar(),
    );
  }
}
