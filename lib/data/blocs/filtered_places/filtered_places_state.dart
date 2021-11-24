import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';

abstract class FilteredPlacesState extends Equatable {
  const FilteredPlacesState();

  @override
  List<Object?> get props => [];
}

class FilteredPlacesLoadInProgress extends FilteredPlacesState {}

class FilteredPlacesLoadSuccess extends FilteredPlacesState {
  final List<Place> places;

  const FilteredPlacesLoadSuccess(this.places);

  @override
  List<Object?> get props => [places];

  @override
  String toString() => 'FiltredPlacesLoadSuccess {places: $places}';
}

class FilteredPlacesLoadError extends FilteredPlacesState {
  final String message;

  const FilteredPlacesLoadError(this.message);

  @override
  List<Object?> get props => [message];
}

class CountChenging extends FilteredPlacesState {
  final int count;

  const CountChenging(this.count);

  @override
  List<Object> get props => [count];
}

class SelectedCategoryLoaded extends FilteredPlacesState {
  final List<String> categories;
  final int count;

  const SelectedCategoryLoaded({required this.categories, required this.count});

  @override
  List<Object> get props => [categories];
}

class RangeValuesLoaded extends FilteredPlacesState {
  final RangeValues rangeValues;

  RangeValuesLoaded(this.rangeValues);

  @override
  List<Object> get props => [rangeValues];
}