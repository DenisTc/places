import 'package:equatable/equatable.dart';
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

