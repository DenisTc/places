import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/common/error_handler.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:provider/src/provider.dart';
import 'package:relation/relation.dart';

class PlaceCategoryScreenWidgetModel extends WidgetModel {
  final SearchInteractor _searchInteractor;

  final categoriesState = EntityStreamedState<List<String>>();
  final updateListCategories = StreamedAction<void>();

  PlaceCategoryScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._searchInteractor,
  ) : super(baseDependencies);

  static PlaceCategoryScreenWidgetModel builder(BuildContext context) {
    final wmDependencies = WidgetModelDependencies(
      errorHandler: context.read<StandardErrorHandler>(),
    );
    return PlaceCategoryScreenWidgetModel(
      wmDependencies,
      context.read<SearchInteractor>(),
    );
  }

  @override
  void onLoad() {
    super.onLoad();

    _loadCategories(true);
  }

  @override
  void onBind() {
    super.onBind();

    subscribe<void>(updateListCategories.stream, (_) {
      _loadCategories(false);
    });
  }

  void _loadCategories(bool hidden) {
    if (hidden) categoriesState.loading();

    subscribeHandleError<List<String>>(
      _searchInteractor.getCategoriesStream(),
      (categories) {
        categoriesState.content(categories);
      },
      onError: (error) {
        categoriesState.error();
      },
    );
  }
}
