import 'package:places/domain/place.dart';

/// State of filtered places
abstract class FilteredPlacesState {}

class FilteredPlacesInitialState extends FilteredPlacesState {}

class FilteredPlacesLoadingState extends FilteredPlacesState {}

class FilteredPlacesErrorState extends FilteredPlacesState {
  final String message;

  FilteredPlacesErrorState(this.message);
}

class FilteredPlacesDataState extends FilteredPlacesState {
  final List<Place> places;

  FilteredPlacesDataState(this.places);
}

// filters
class FilteredCategoriesLoadingState extends FilteredPlacesState {}

class FilteredCategoriesErrorState extends FilteredPlacesState {
  final String message;

  FilteredCategoriesErrorState(this.message);
}

// categories
class CategoriesDataState extends FilteredPlacesState {
  final List<String> categories;

  CategoriesDataState(this.categories);
}