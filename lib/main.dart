import 'package:flutter/material.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/ui/screens/splash_screen.dart';

final settings = SettingsInteractor();
final api = ApiClient().client;

final _searchRepository = SearchRepository(api);
final _placeRepository = PlaceRepository(api);
final placeInteractor = PlaceInteractor(_placeRepository);
final searchInteractor = SearchInteractor(_searchRepository);

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
}
