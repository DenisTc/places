import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/data/blocs/place/bloc/place_bloc.dart';
import 'package:places/data/blocs/theme/bloc/theme_bloc.dart';
import 'package:places/data/redux/middleware/filtered_place_middleware.dart';
import 'package:places/data/redux/reducer/reducer.dart';
import 'package:places/data/redux/state/filtered_places_state.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/data/repository/theme_repository.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:redux/redux.dart';

import 'data/redux/state/app_state.dart';

void main() {
  final _store = Store<AppState>(
    reducerApp,
    initialState: AppState(filteredPlacesState: FilteredPlacesInitialState()),
    middleware: [
      PlaceMiddleware(SearchRepository()),
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
