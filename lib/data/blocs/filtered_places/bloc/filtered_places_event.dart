import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/search_filter.dart';

class FilteredPlacesEvent extends Equatable {
  const FilteredPlacesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFilteredPlaces extends FilteredPlacesEvent {
  final SearchFilter? filters;

  LoadFilteredPlaces([this.filters]);

  @override
  List<Object> get props => [];
}

class LoadFilterParamsEvent extends FilteredPlacesEvent {}

class ClearFilterEvent extends FilteredPlacesEvent {}

class LoadPlaceCategoriesEvent extends FilteredPlacesEvent {}

class ToggleCategoryEvent extends FilteredPlacesEvent {
  final String name;

  ToggleCategoryEvent(this.name);

  @override
  List<Object> get props => [name];
}

class UpdateDistanceEvent extends FilteredPlacesEvent {
  final RangeValues distance;

  UpdateDistanceEvent(this.distance);

  @override
  List<Object> get props => [distance];
}

class SaveSearchFilterEvent extends FilteredPlacesEvent {}
