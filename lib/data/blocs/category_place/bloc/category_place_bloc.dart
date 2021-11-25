import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/repository/search_repository.dart';

part 'category_place_event.dart';
part 'category_place_state.dart';

class PlaceCategoriesBloc
    extends Bloc<PlaceCategoriesEvent, PlaceCategoriesState> {
  final SearchRepository searchRepository;
  List<String> selectedCategories = [];
  PlaceCategoriesBloc(this.searchRepository) : super(PlaceCategoriesInitial());

  @override
  Stream<PlaceCategoriesState> mapEventToState(
    PlaceCategoriesEvent event,
  ) async* {
    yield PlaceCategoriesLoading();

    if (event is LoadPlaceCategories) {
      try {
        var res = await getCategories();

        if (res is List<String>) {
          yield PlaceCategoriesLoaded(res);
        } else {
          yield LoadPlaceCategoriesError(res.toString());
        }
      } catch (e) {
        yield LoadPlaceCategoriesError(e.toString());
      }
    }

    if (event is ToggleCategory) {
        if (selectedCategories.contains(event.name)) {
          selectedCategories.remove(event.name);
        } else {
          selectedCategories.add(event.name);
        }

        yield CategoryToggled(selectedCategories);
      }
  }

  Future<List<String>> getCategories() async {
    final _placesList = await searchRepository.getCategories();
    final _categoryList = <String>[];

    for (final place in _placesList) {
      if (!_categoryList.contains(place.placeType)) {
        _categoryList.add(place.placeType);
      }
    }
    return _categoryList;
  }
}
