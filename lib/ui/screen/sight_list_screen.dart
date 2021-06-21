import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatefulWidget {
  @override
  createState() => new SightListScreenState();
}

class SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SightAppBar("Список\nинтересных мест",128),
        body: SingleChildScrollView(
            child: Column(children: [
          SightCard(mocks[0]),
          SightCard(mocks[1]),
          SightCard(mocks[2]),
          SightCard(mocks[3])
        ])));
  }
}

class SightAppBar extends StatelessWidget implements PreferredSizeWidget{ 
  final String title;
  final double height;

  const SightAppBar(this.title, this.height);

  @override
  Size get preferredSize => Size.fromHeight(height);
  
  @override 
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          toolbarHeight: height,
          title: Text(title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: "#252849".toColor())),
        );
  }
}
