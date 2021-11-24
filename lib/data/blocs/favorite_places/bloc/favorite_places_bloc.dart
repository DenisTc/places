import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

part 'favorite_places_event.dart';
part 'favorite_places_state.dart';

class FavoritePlaceBloc extends Bloc<FavoritePlaceEvent, FavoritePlaceState> {
  final PlaceRepository placeRepository;
  Set<int> favoriteList = {};
  Map<Place, DateTime> visitedList = {};
  FavoritePlaceBloc(this.placeRepository) : super(FavoritePlaceInitial());

  @override
  Stream<FavoritePlaceState> mapEventToState(
    FavoritePlaceEvent event,
  ) async* {
    yield FavoritePlaceLoading();

    if (event is PlaceIsFavorite) {
      try {
        var status = await placeRepository.isFavoritePlace(event.place);
        if (status) favoriteList.add(event.place.id);

        yield PlaceCheckIsFavorite(favoriteList);
      } catch (e) {
        yield FavoritePlaceError(e.toString());
      }
    }

    if (event is PlaceIsVisited) {
      // var status = await placeRepository.isVisitedPlace(event.place);
      
      yield PlaceCheckIsVisited(placeRepository.visitPlaces);
    }

    if (event is PlaceToggleInVisited) {
      await placeRepository.toggleInVisited(event.place, event.date);
      var status = await placeRepository.isVisitedPlace(event.place);
      if (status) visitedList[event.place] = event.date;

      yield PlaceCheckIsVisited(visitedList);
    }

    if (event is PlaceToggleInFavorites) {
      await placeRepository.toggleInFavorites(event.place);
      var status = await placeRepository.isFavoritePlace(event.place);

      if (status) {
        favoriteList.add(event.place.id);
      } else {
        favoriteList.remove(event.place.id);
      }
      yield PlaceCheckIsFavorite(favoriteList);
    }

    if (event is LoadAllFavoritePlaces) {
      List<Place> places = await placeRepository.getFavoritesPlaces();

      yield FavoritePlacesListLoaded(places);
    }

    if (event is LoadAllVisitedPlaces) {
      Map<Place, DateTime> places = await placeRepository.getVisitPlaces();
      List<Place> visitedPlaces = places.entries.map((place) => place.key).toList();
      yield VisitedPlacesListLoaded(visitedPlaces);
    }
  }
}
