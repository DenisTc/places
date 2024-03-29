import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';

part 'favorite_place_event.dart';
part 'favorite_place_state.dart';

class FavoritePlaceBloc extends Bloc<FavoritePlaceEvent, FavoritePlaceState> {
  final PlaceInteractor _placeInteractor;

  FavoritePlaceBloc(this._placeInteractor) : super(FavoritePlaceInitial()) {
    on<LoadListFavoritePlaces>(
      (event, emit) => _loadListFavoritePlaces(emit),
    );

    on<TogglePlaceInFavorites>(_togglePlaceInFavorites);
  }

  Future<void> _loadListFavoritePlaces(
    Emitter<FavoritePlaceState> emit,
  ) async {
    final favoriteList = await _placeInteractor.getFavoritePlaces();

    emit(ListFavoritePlacesLoaded(favoriteList));
  }

  Future<void> _togglePlaceInFavorites(
    TogglePlaceInFavorites event,
    Emitter<FavoritePlaceState> emit,
  ) async {
    emit(ListFavoritePlacesLoading());

    final isContain = await _placeInteractor.isFavoritePlace(event.place);

    if (isContain) {
      await _placeInteractor.deletePlaceFromFavorites(event.place);
      await _placeInteractor.deletePlaceFromCache(event.place);
    } else {
      await _placeInteractor.addPlaceToFavorites(event.place);
      await _placeInteractor.addPlaceToCache(event.place);
    }

    final favoriteList = await _placeInteractor.getFavoritePlaces();

    emit(ListFavoritePlacesLoaded(favoriteList));
  }
}
