import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/sight_bottom_nav_bar.dart';
import 'package:places/ui/screens/sight_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
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
          Positioned(
            bottom: 16,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gorse, lightGreen]),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    SvgPicture.asset(
                      iconPlus,
                      height: 16,
                      width: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'новое место'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  minimumSize: MaterialStateProperty.all(Size(180, 48)),
                  shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
              ),
            ),
          ),
        ],
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
