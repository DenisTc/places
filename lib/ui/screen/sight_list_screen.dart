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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          toolbarHeight: 128,
          title: Text("Список\nинтересных мест",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: "#252849".toColor())),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SightCard(mocks[0]),
          SightCard(mocks[1]),
          SightCard(mocks[2]),
          SightCard(mocks[3])
        ])));
  }
}
