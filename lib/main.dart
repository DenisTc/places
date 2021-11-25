import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/category_place/bloc/category_place_bloc.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/data/blocs/place/bloc/place_bloc.dart';
import 'package:places/data/blocs/theme/bloc/theme_bloc.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/data/repository/theme_repository.dart';
import 'package:places/ui/screens/splash_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlaceBloc>(
            create: (context) => PlaceBloc(PlaceRepository())),
        BlocProvider<FilteredPlacesBloc>(
            create: (context) => FilteredPlacesBloc(SearchRepository())),
        BlocProvider<FavoritePlaceBloc>(
            create: (context) => FavoritePlaceBloc(PlaceRepository())),
        BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(ThemeRepository())),
        BlocProvider<PlaceCategoriesBloc>(
            create: (context) => PlaceCategoriesBloc(SearchRepository())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Sights',
          theme: state.theme,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
