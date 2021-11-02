import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PlaceInteractor>.value(value: PlaceInteractor()),
        Provider<SearchInteractor>.value(value: SearchInteractor()),
        ChangeNotifierProvider<SettingsInteractor>.value(
          value: SettingsInteractor(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<SettingsInteractor>(context).getTheme;
    return MaterialApp(
      title: 'Sights',
      theme: _theme,
      home: const SplashScreen(),
    );
  }
}
