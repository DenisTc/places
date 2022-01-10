import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/data/blocs/filter_bloc/filter_bloc.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/data/blocs/place/bloc/place_bloc.dart';
import 'package:places/data/blocs/theme/bloc/theme_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/data/repository/theme_repository.dart';
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
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(
            ThemeRepository(),
          ),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Places',
            theme: state.theme,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
