import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

part 'favorite_place_event.dart';
part 'favorite_place_state.dart';

class FavoritePlaceBloc extends Bloc<FavoritePlaceEvent, FavoritePlaceState> {
  final PlaceRepository placeRepository;
  List<Place> favoriteList = [];

  FavoritePlaceBloc(this.placeRepository) : super(FavoritePlaceInitial());

  @override
  Stream<FavoritePlaceState> mapEventToState(
    FavoritePlaceEvent event,
  ) async* {
    yield ListFavoritePlacesLoading();

    if (event is TogglePlaceInFavorites) {
      await placeRepository.toggleInFavorites(event.place);
      var status = await placeRepository.isFavoritePlace(event.place);

      if (status) {
        favoriteList.add(event.place);
      } else {
        favoriteList.remove(event.place);
      }
      yield ListFavoritePlacesLoaded(favoriteList);
    }

    if(event is LoadListFavoritePlaces) {
      yield ListFavoritePlacesLoaded(favoriteList);
    }
    
  }
}
