import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';

part 'favorite_place_event.dart';
part 'favorite_place_state.dart';

class FavoritePlaceBloc extends Bloc<FavoritePlaceEvent, FavoritePlaceState> {
  final PlaceInteractor _placeInteractor;
  List<Place> favoriteList = [];

  FavoritePlaceBloc(this._placeInteractor) : super(FavoritePlaceInitial()) {
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

    await _placeInteractor.toggleInFavorites(event.place);
    var status = await _placeInteractor.isFavoritePlace(event.place);

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
