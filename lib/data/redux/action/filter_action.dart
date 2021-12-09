import 'package:flutter/material.dart';
import 'package:places/domain/search_filter.dart';

abstract class FilterActions {}

class LoadFilterAction extends FilterActions {}

class ClearFilterAction extends FilterActions {}

class ResultFilterAction extends FilterActions {
  final SearchFilter filter;
  final int count;

  ResultFilterAction(this.filter, this.count);
}

class ToggleCategoryAction extends FilterActions {
  final String type;

  ToggleCategoryAction(this.type);
}

class ChangeDistanceFilterAction extends FilterActions {
  final RangeValues value;

  ChangeDistanceFilterAction(this.value);
}

class LoadCountFilteredPlacesAction extends FilterActions {}

class UpdateFilterAction extends FilterActions {}
