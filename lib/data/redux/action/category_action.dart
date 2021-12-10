/// Abstract class for interaction with filtered places
abstract class CategoryActions {}

/// Loading categories for the filters screen
class LoadCategoriesAction extends CategoryActions {}

/// Loading categories for the filters screen
class ErrorCategoriesAction extends CategoryActions {
  final String message;

  ErrorCategoriesAction(this.message);
}

/// Result of loading categories for the filters screen
class ResultCategoriesAction extends CategoryActions {
  final List<String> categories;

  ResultCategoriesAction(this.categories);
}
