import 'package:places/data/redux/action/category_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/category_state.dart';

AppState loadCategoriesReducer(AppState state, LoadCategoriesAction action){
  return state.copyWith(categoryState: CategoriesLoadingState());
}

AppState errorCategoriesReducer(AppState state, ErrorCategoriesAction action){ 
  return state.copyWith(categoryState: CategoriesErrorState(action.message));
}

AppState resultCategoriesReducer(AppState state, ResultCategoriesAction action){
  return state.copyWith(categoryState: CategoriesDataState(action.categories));
}