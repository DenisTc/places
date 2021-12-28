import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/common/error_handler.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/search_filter.dart';
import 'package:relation/relation.dart';

class PlaceListScreenWidgetModel extends WidgetModel {
  final SearchInteractor _searchInteractor;

  final placeListState = EntityStreamedState<List<Place>>();

  final updatePlaceListAction = StreamedAction<void>();

  PlaceListScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._searchInteractor,
  ) : super(baseDependencies);

  static PlaceListScreenWidgetModel builder(BuildContext context) {
    final wmDependencies = WidgetModelDependencies(
      errorHandler: context.read<StandardErrorHandler>(),
    );
    return PlaceListScreenWidgetModel(
      wmDependencies,
      context.read<SearchInteractor>(),
    );
  }

  @override
  void onLoad() {
    super.onLoad();

    _loadPlaceList(true);
  }

  @override
  void onBind() {
    super.onBind();

    subscribe<void>(updatePlaceListAction.stream, (_) {
      _loadPlaceList(false);
    });
  }

  void _loadPlaceList(bool hidden) {
    if (hidden) placeListState.loading();

    subscribeHandleError<List<Place>>(
      _searchInteractor.getFiltredPlacesStream(SearchFilter()),
      (places) {
        placeListState.content(places);
      },
      onError: (error) {
        placeListState.error();
      },
    );
  }
}
