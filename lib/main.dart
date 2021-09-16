import 'package:flutter/material.dart';
import 'package:places/data/repository/dio.dart';
import 'package:places/data/interactor/settings.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/screens/splash_screen.dart';

final settings = Settings();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    testNetworkCall();
    settings.addListener(
      () => setState(() {}),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sights',
      theme: settings.getTheme,
      home: const SplashScreen(),
    );
  }

  void testNetworkCall() async {
    final placeRepository = PlaceRepository();
    // final response = await placeRepository.getPlace(id: 172);
    // debugPrint('Response HTTP call = ${response.name}');

    final response = await placeRepository.getListPlacesByPost();
    debugPrint('Response HTTP call = ${response.places.length}');
  }
}
