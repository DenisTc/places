import 'package:flutter/material.dart';
import 'package:places/common/error_handler.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/data/repository/theme_repository.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SearchInteractor>(
          create: (_) => SearchInteractor(SearchRepository()),
        ),
        Provider<PlaceInteractor>(
          create: (_) => PlaceInteractor(PlaceRepository()),
        ),
        Provider<StandardErrorHandler>(
          create: (_) => StandardErrorHandler(),
        )
      ],
      child: MaterialApp(
        title: 'Sights',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
