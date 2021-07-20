import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/sight_bottom_nav_bar.dart';
import 'package:places/ui/screens/sight_card.dart';

class SightListScreen extends StatefulWidget {
  @override
  createState() => new SightListScreenState();
}

class SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: _SightAppBar("Список\nинтересных мест", 128),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SightCard(mocks[0]),
            SightCard(mocks[1]),
            SightCard(mocks[2]),
            SightCard(mocks[3])
          ],
        ),
      ),
      bottomNavigationBar: SightBottomNavBar(),
    );
  }
}

class _SightAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const _SightAppBar(this.title, this.height);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: height,
      title: Text(
        title,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
