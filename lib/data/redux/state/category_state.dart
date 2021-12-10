/// State of category
abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoriesLoadingState extends CategoryState {}

class CategoriesErrorState extends CategoryState {
  final String message;

  CategoriesErrorState(this.message);
}

class CategoriesDataState extends CategoryState {
  final List<String> categories;

  CategoriesDataState(this.categories);
}
