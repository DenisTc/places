import 'package:places/data/redux/action/category_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/repository/search_repository.dart';
import 'package:redux/redux.dart';

class CategoryMiddleware implements MiddlewareClass<AppState> {
  final SearchRepository _searchRepository;
  CategoryMiddleware(this._searchRepository);

  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is LoadCategoriesAction) {
      final _placesList = await _searchRepository.getCategories();
      final _categoryList = <String>[];

      for (final place in _placesList) {
        if (!_categoryList.contains(place.placeType)) {
          _categoryList.add(place.placeType);
        }
      }

      return store.dispatch(ResultCategoriesAction(_categoryList));
    }

    next(action);
  }
}
