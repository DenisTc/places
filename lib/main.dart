import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_client.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/data/blocs/filter/bloc/filter_bloc.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/data/blocs/geolocation/geolocation_bloc.dart';
import 'package:places/data/blocs/map/places_map_bloc.dart';
import 'package:places/data/blocs/place/bloc/place_bloc.dart';
import 'package:places/data/blocs/visited_place/visited_place_bloc.dart';
import 'package:places/data/cubits/history/history_cubit.dart';
import 'package:places/data/cubits/theme/theme_cubit.dart';
import 'package:places/data/interactor/history_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/repository/history_repository.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/database/database.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final api = ApiClient();
  final localDb = LocalDatabase();
  final storage = SharedStorage();

  App({Key? key}) : super(key: key);

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
              PlaceRepository(api: api, db: localDb),
            ),
          ),
        ),
        BlocProvider<FavoritePlaceBloc>(
          create: (context) => FavoritePlaceBloc(
            PlaceInteractor(
              PlaceRepository(api: api, db: localDb),
            ),
          ),
        ),
        BlocProvider<VisitedPlaceBloc>(
          create: (context) => VisitedPlaceBloc(
            PlaceInteractor(
              PlaceRepository(api: api, db: localDb),
            ),
          ),
        ),
        BlocProvider<HistoryCubit>(
          create: (context) => HistoryCubit(
            HistoryInteractor(
              HistoryRepository(localDb),
            ),
          ),
        ),
        BlocProvider<PlacesMapBloc>(
          create: (context) => PlacesMapBloc(
            searchInteractor: SearchInteractor(
              SearchRepository(api),
            ),
            storage: storage,
          ),
        ),
        BlocProvider<GeolocationBloc>(
          create: (context) => GeolocationBloc(
            storage: storage,
          ),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(storage),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
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
