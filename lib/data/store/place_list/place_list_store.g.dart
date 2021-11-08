// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceListStore on PlaceListStoreBase, Store {
  final _$placeListAtom = Atom(name: 'PlaceListStoreBase.placeList');

  @override
  ObservableFuture<List<Place>> get placeList {
    _$placeListAtom.reportRead();
    return super.placeList;
  }

  @override
  set placeList(ObservableFuture<List<Place>> value) {
    _$placeListAtom.reportWrite(value, super.placeList, () {
      super.placeList = value;
    });
  }

  final _$loadListAsyncAction = AsyncAction('PlaceListStoreBase.loadList');

  @override
  Future<void> loadList({bool isHidden = false}) {
    return _$loadListAsyncAction.run(() => super.loadList(isHidden: isHidden));
  }

  @override
  String toString() {
    return '''
placeList: ${placeList}
    ''';
  }
}
