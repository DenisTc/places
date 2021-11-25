import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/place.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository placeRepository;
  PlaceBloc(this.placeRepository) : super(PlaceInitial());

  @override
  Stream<PlaceState> mapEventToState(
    PlaceEvent event,
  ) async* {
    yield PlaceDetailsLoading();

    if (event is LoadPlaceDetails) {
      try {
        var res = await placeRepository.getPlaceDetails(id: event.id);

        if (res is Place) {
          yield PlaceDetailsLoaded(res);
        } else {
          yield PlaceDetailsLoadError(res.toString());
        }
      } catch (e) {
        yield PlaceDetailsLoadError(e.toString());
      }
    }
  }
}