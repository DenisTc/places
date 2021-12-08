import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/redux/middleware/favorite_places_middleware.dart';
import 'package:places/data/redux/middleware/filtered_place_middleware.dart';
import 'package:places/data/redux/middleware/place_middleware.dart';
import 'package:places/data/redux/reducer/reducer.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/favorite_places_state.dart';
import 'package:places/data/redux/state/filtered_places_state.dart';
import 'package:places/data/redux/state/place_state.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/data/repository/theme_repository.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:redux/redux.dart';

void main() {
  final _store = Store<AppState>(
    reducerApp,
    initialState: AppState(
      filteredPlacesState: FilteredPlacesInitialState(),
      favoritePlacesState: FavoritePlacesInitialState(),
      placeState: PlaceInitialState(),
    ),
    middleware: [
      FilteredMiddleware(SearchRepository()),
      FavoriteMiddleware(),
      PlaceMiddleware(PlaceRepository()),
    ],
  );

  runApp(App(store: _store));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  App({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Sights',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
