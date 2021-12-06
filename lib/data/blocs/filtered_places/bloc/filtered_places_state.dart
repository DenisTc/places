import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/settings_filter.dart';

abstract class FilteredPlacesState extends Equatable {
  const FilteredPlacesState();

  @override
  List<Object> get props => [];
}

class LoadFilteredPlacesInProgress extends FilteredPlacesState {}

class LoadFilteredPlacesError extends FilteredPlacesState {
  final String message;

  const LoadFilteredPlacesError(this.message);

  @override
  List<Object> get props => [message];
}

class LoadFilteredPlacesSuccess extends FilteredPlacesState {
  final List<Place> places;

  const LoadFilteredPlacesSuccess(this.places);

  @override
  List<Object> get props => [places];
}

class LoadFilterSuccess extends FilteredPlacesState {
  final int count;
  final SettingsFilter placeFilter;

  const LoadFilterSuccess({required this.count, required this.placeFilter});

  @override
  List<Object> get props => [this.count, this.placeFilter];
}

class LoadCountPlaceSuccess extends FilteredPlacesState {
  final int count;
  final SettingsFilter placeFilter;

  const LoadCountPlaceSuccess({required this.count, required this.placeFilter});

  @override
  List<Object> get props => [this.count, this.placeFilter];
}

class PlaceCategoriesLoading extends FilteredPlacesState {}

class PlaceCategoriesLoaded extends FilteredPlacesState {
  final List<String> categories;
  final List<String> selectedCategories;

  PlaceCategoriesLoaded({required this.categories, required this.selectedCategories});

  @override
  List<Object> get props => [categories];
}

class LoadPlaceCategoriesError extends FilteredPlacesState {
  final String message;

  const LoadPlaceCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryToggled extends FilteredPlacesState {
  final List<String> categories;

  CategoryToggled(this.categories);

  @override
  List<Object> get props => [categories];
}

class ClearSlider extends FilteredPlacesState {
 final RangeValues rangeValues;

  ClearSlider(this.rangeValues);

  @override
  List<Object> get props => [rangeValues];
}