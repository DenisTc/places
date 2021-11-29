import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/settings_filter.dart';

class FilteredPlacesEvent extends Equatable {
  const FilteredPlacesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFilteredPlaces extends FilteredPlacesEvent {
  final SettingsFilter? filters;

  LoadFilteredPlaces([this.filters]);

  @override
  List<Object> get props => [];
}

class LoadFilter extends FilteredPlacesEvent {}

class ClearFilter extends FilteredPlacesEvent {}

class LoadPlaceCategories extends FilteredPlacesEvent {}

class ToggleCategory extends FilteredPlacesEvent {
  final String name;

  ToggleCategory(this.name);

  @override
  List<Object> get props => [name];
}

class UpdateDistance extends FilteredPlacesEvent {
  final RangeValues distance;

  UpdateDistance(this.distance);

  @override
  List<Object> get props => [distance];
}