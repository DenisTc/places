import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: isDarkMode ? darkTheme : lightTheme,
      home: VisitingScreen(),//SightDetails(sight: mocks[0]) //SightDetails(),//VisitingScreen(),//SightListScreen(),
    );
  }
}