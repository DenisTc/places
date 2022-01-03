import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/redux/action/category_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class CategoryMiddleware implements MiddlewareClass<AppState> {
  final SearchInteractor _searchInteractor;
  CategoryMiddleware(this._searchInteractor);

  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is LoadCategoriesAction) {
      final _categoryList = await _searchInteractor.getCategories();

      return store.dispatch(ResultCategoriesAction(_categoryList));
    }

    next(action);
  }
}
