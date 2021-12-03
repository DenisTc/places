import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

part 'favorite_place_event.dart';
part 'favorite_place_state.dart';

class FavoritePlaceBloc extends Bloc<FavoritePlaceEvent, FavoritePlaceState> {
  final PlaceRepository placeRepository;
  List<Place> favoriteList = [];

  FavoritePlaceBloc(this.placeRepository) : super(FavoritePlaceInitial()) {
    on<LoadListFavoritePlaces>(
      (event, emit) => _loadListFavoritePlaces(event, emit),
    );

    on<TogglePlaceInFavorites>(
      (event, emit) => _togglePlaceInFavorites(event, emit),
    );
  }

  void _loadListFavoritePlaces(
    LoadListFavoritePlaces event,
    Emitter<FavoritePlaceState> emit,
  ) {
    emit(
      ListFavoritePlacesLoaded(favoriteList),
    );
  }

  void _togglePlaceInFavorites(
    TogglePlaceInFavorites event,
    Emitter<FavoritePlaceState> emit,
  ) async {
    emit(ListFavoritePlacesLoading());

    await placeRepository.toggleInFavorites(event.place);
    var status = await placeRepository.isFavoritePlace(event.place);

    if (status) {
      favoriteList.add(event.place);
    } else {
      favoriteList.remove(event.place);
    }

    emit(
      ListFavoritePlacesLoaded(favoriteList),
    );
  }
}
