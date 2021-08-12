import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/models/settings.dart';
import 'package:places/ui/screens/add_sight_screen.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/sight_category_screen.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/sight_search_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

final settings = Settings();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    settings.addListener(
      () => setState(() {}),
    );
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: settings.getTheme,
      home:
          VisitingScreen(), //SightListScreen()//SightDetails(sight: mocks[0]) //SightDetails(),//VisitingScreen(),//SightListScreen(),
    );
  }
}