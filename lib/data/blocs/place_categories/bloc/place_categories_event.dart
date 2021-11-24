part of 'place_categories_bloc.dart';

abstract class PlaceCategoriesEvent extends Equatable {
  const PlaceCategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaceCategories extends PlaceCategoriesEvent {}
