import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FilteredPlacesEvent extends Equatable {
  const FilteredPlacesEvent();

  @override
  List<Object?> get props => [];
}

class FilteredPlacesLoad extends FilteredPlacesEvent {}

// class GetCountOfFilteredPlaces extends FilteredPlacesEvent {
//   final int count;

//   GetCountOfFilteredPlaces(this.count);

//   @override
//   List<Object> get props => [count];
// }

class ToggleCategory extends FilteredPlacesEvent {
  final String name;

  ToggleCategory(this.name);

  @override
  List<Object> get props => [name];
}

class GetRangeValues extends FilteredPlacesEvent {}

class SetRangeValues extends FilteredPlacesEvent {
  final RangeValues rangeValues;

  SetRangeValues(this.rangeValues);

  @override
  List<Object> get props => [rangeValues];
}
