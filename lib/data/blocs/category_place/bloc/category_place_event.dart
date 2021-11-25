part of 'category_place_bloc.dart';

abstract class PlaceCategoriesEvent extends Equatable {
  const PlaceCategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaceCategories extends PlaceCategoriesEvent {}

class ToggleCategory extends PlaceCategoriesEvent {
  final String name;

  ToggleCategory(this.name);

  @override
  List<Object> get props => [name];
}