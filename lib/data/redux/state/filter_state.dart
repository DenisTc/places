import 'package:places/domain/search_filter.dart';

/// State of filter
abstract class FilterState {}

class FilterInitialState extends FilterState {}

class FilterLoadSuccessState extends FilterState {
  final SearchFilter filter;
  final int count;

  FilterLoadSuccessState(this.filter, this.count);
}

class LoadCountFilteredPlacesSuccessState extends FilterState {
  final int count;

  LoadCountFilteredPlacesSuccessState(this.count);
}
