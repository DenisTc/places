import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';

/// Abstract class for interaction with filtered places
abstract class FilteredPlacesActions {}

/// Load filtered places
class LoadFilteredPlacesAction extends FilteredPlacesActions {}

/// Returning Error while getting the list of filtered places
class ErrorFilteredPlacesAction extends FilteredPlacesActions {
  final String message;

  ErrorFilteredPlacesAction(this.message);
}

/// Result of loading filtered places
class ResultFilteredPlacesAction extends FilteredPlacesActions {
  final List<Place> places;

  ResultFilteredPlacesAction(this.places);
}

/// Loading categories for the filters screen
class LoadCategoriesAction extends FilteredPlacesActions {}

/// Result of loading categories for the filters screen
class ResultCategoriesAction extends FilteredPlacesActions {
  final List<String> categories;

  ResultCategoriesAction(this.categories);
}

/// Update distance value in filter
class UpdateFilterDistanceAction extends FilteredPlacesActions {
  final RangeValues values;

  UpdateFilterDistanceAction(this.values);
}
