import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/sight_bottom_nav_bar.dart';
import 'package:places/ui/widgets/card/sight_card.dart';
import 'package:places/ui/widgets/main_list_screen/add_sight_button.dart';
import 'package:places/ui/widgets/main_list_screen/search_bar.dart';
import 'package:places/ui/widgets/main_list_screen/sight_app_bar.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

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
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              itemCount: mocks.length,
              itemBuilder: (BuildContext context, int index) {
                final sight = mocks[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SightCard(sight: sight),
                );
              },
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
          const AddSightButton(),
        ],
      ),
      bottomNavigationBar: const SightBottomNavBar(),
    );
  }
}