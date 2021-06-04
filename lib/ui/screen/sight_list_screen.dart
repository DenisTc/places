import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  @override
  createState() => new SightListScreenState();
}

class SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Список\nинтересных мест",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: "#252849".toColor())),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          toolbarHeight: 80,),
      body: Center(child: Text("Hello!")),
    );
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
