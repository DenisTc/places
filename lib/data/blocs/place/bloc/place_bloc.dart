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
    yield PlaceLoading();

    if (event is LoadPlace) {
      try {
        var res = await placeRepository.getPlaceDetails(id: event.id);

        if (res is Place) {
          yield PlaceLoaded(res);
        } else {
          yield PlaceError(res.toString());
        }
      } catch (e) {
        yield PlaceError(e.toString());
      }
    }
  }
}
