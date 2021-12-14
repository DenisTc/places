import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/common/error_handler.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:provider/src/provider.dart';
import 'package:relation/relation.dart';

class AddSightScreenWidgetModel extends WidgetModel {
  final PlaceInteractor placeInteractor;

  final placeState = EntityStreamedState<Place>();

  final addNewPlaceAction = StreamedAction<void>();
  final submitTextField = StreamedAction<FocusNode>();

  /// FormFields
  final controllerCat = TextEditingController();
  final controllerName = TextEditingController();
  final controllerLat = TextEditingController();
  final controllerLng = TextEditingController();
  final controllerDesc = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode latFocusNode = FocusNode();
  final FocusNode lngFocusNode = FocusNode();
  final FocusNode descFocusNode = FocusNode();

  /// Button
  bool isButtonEnabled = false;
  final StreamedState<bool> isSubmitEnabled = StreamedState(false);

  double? _lat;
  double? _lng;
  String? _name;
  List<String>? _urls;
  String? _placeType;
  String? _description;
  List<String> _images = [];

  set lat(double lat) {
    _lat = lat;
  }

  set lng(double lng) {
    _lng = lng;
  }

  set name(String name) {
    _name = name;
  }

  set urls(List<String> urls) {
    _urls = urls;
  }

  set placeType(String placeType) {
    _placeType = placeType;
  }

  set description(String description) {
    _description = description;
  }

  AddSightScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.placeInteractor,
  ) : super(baseDependencies);

  static AddSightScreenWidgetModel builder(BuildContext context) {
    final wmDependencies = WidgetModelDependencies(
      errorHandler: context.read<StandardErrorHandler>(),
    );
    return AddSightScreenWidgetModel(
      wmDependencies,
      context.read<PlaceInteractor>(),
    );
  }

  @override
  void onLoad() {
    super.onLoad();

    // addNewPlace();
  }

  @override
  void onBind() {
    super.onBind();

    // subscribe(submitTextField.stream, checkFields);

    // subscribe<void>(addNewPlaceAction.stream, (_) {
    // _addNewPlace(hidden: false, place: _place);
    // });
    // if (
    // controllerCat.text.isNotEmpty &&
    // controllerName.text.isNotEmpty &&
    // controllerLat.text.isNotEmpty &&
    // controllerLng.text.isNotEmpty &&
    //     controllerDesc.text.isNotEmpty) {
    //   isButtonEnabled = true;
    // } else {
    //   isButtonEnabled = false;
    // }
  }

  void checkFields() {
    if (
        controllerCat.text.isNotEmpty &&
        controllerName.text.isNotEmpty &&
        controllerLat.text.isNotEmpty &&
        controllerLng.text.isNotEmpty &&
        controllerDesc.text.isNotEmpty) {
      isSubmitEnabled.accept(true);
    } else {
      isSubmitEnabled.accept(false);
    }
  }

  void addNewPlace({bool hidden = true, Place? place}) {
    if (hidden) placeState.loading();

    // subscribeHandleError<Place>(
    //   // _searchInteractor.getFiltredPlacesStream(SearchFilter()),
    //   placeInteractor.addNewPlace(place!),
    //   (place) {
    //     placeState.content(place);
    //   },
    //   onError: (error) {
    //     placeState.error();
    //   },
    // );
  }
}
