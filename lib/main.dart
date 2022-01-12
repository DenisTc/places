import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/data/blocs/filter/bloc/filter_bloc.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/data/blocs/place/bloc/place_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/database/database.dart';
import 'package:places/domain/theme_app.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final api = ApiClient();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<FilteredPlacesBloc>(
          create: (context) => FilteredPlacesBloc(
            SearchInteractor(
              SearchRepository(api),
            ),
          ),
        ),
        BlocProvider<FilterBloc>(
          create: (context) => FilterBloc(
            SearchInteractor(
              SearchRepository(api),
            ),
          ),
        ),
        BlocProvider<PlaceBloc>(
          create: (context) => PlaceBloc(
            PlaceInteractor(
              PlaceRepository(api),
            ),
          ),
        ),
        BlocProvider<FavoritePlaceBloc>(
          create: (context) => FavoritePlaceBloc(
            PlaceInteractor(
              PlaceRepository(api),
            ),
          ),
        ),
        Provider<LocalDatabase>(
          create: (_) => LocalDatabase(),
        ),
      ],
      child: ChangeNotifierProvider<ThemeApp>(
        create: (_) => ThemeApp(),
        child: Consumer<ThemeApp>(
          builder: (context, value, child) {
            return MaterialApp(
              title: 'Places',
              theme: value.getTheme,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
