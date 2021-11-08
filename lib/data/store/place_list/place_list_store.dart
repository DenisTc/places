import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';

part 'place_list_store.g.dart';

class PlaceListStore = PlaceListStoreBase with _$PlaceListStore;

abstract class PlaceListStoreBase with Store {
  final PlaceInteractor _placeInteractor;

  @observable
  ObservableFuture<List<Place>> placeList = ObservableFuture.value([]);

  PlaceListStoreBase(this._placeInteractor);

  @action
  Future<void> loadList({bool isHidden = false}) async {
    final future = _placeInteractor.getPlaces();
    placeList = ObservableFuture(future);
  }
}
