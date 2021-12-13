import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/common/error_handler.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/redux/middleware/category_middleware.dart';
import 'package:places/data/redux/middleware/favorite_places_middleware.dart';
import 'package:places/data/redux/middleware/filter_middleware.dart';
import 'package:places/data/redux/middleware/filtered_place_middleware.dart';
import 'package:places/data/redux/middleware/place_middleware.dart';
import 'package:places/data/redux/middleware/theme_middleware.dart';
import 'package:places/data/redux/reducer/reducer.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/category_state.dart';
import 'package:places/data/redux/state/favorite_places_state.dart';
import 'package:places/data/redux/state/filter_state.dart';
import 'package:places/data/redux/state/filtered_places_state.dart';
import 'package:places/data/redux/state/place_state.dart';
import 'package:places/data/redux/state/theme_state.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/data/repository/theme_repository.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

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
