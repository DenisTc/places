import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/common/error_handler.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:provider/src/provider.dart';
import 'package:relation/relation.dart';

class AddSightScreenWidgetModel extends WidgetModel {
  final PlaceInteractor placeInteractor;

  final placeState = EntityStreamedState<void>();

  final addNewPlaceAction = StreamedAction<void>();
  final submitTextField = StreamedAction<void>();
  final addImagesAction = StreamedAction<List<String>>();
  final deleteImagesAction = StreamedAction<void>();

  List<String> placeImages = [];


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

  /// Button state
  final StreamedState<bool> buttonState = StreamedState(false);

  /// Gallery state of the new place
  final StreamedState<List<String>> galleryState = StreamedState([]);

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
  }

  @override
  void onBind() {
    super.onBind();

    subscribe<List<String>>(addImagesAction.stream, uploadImages);

    subscribe<void>(addNewPlaceAction.stream, (_) {
      addNewPlace();
    });
  }

  void checkFields() {
    if (controllerCat.text.isNotEmpty &&
        controllerName.text.isNotEmpty &&
        controllerLat.text.isNotEmpty &&
        controllerLng.text.isNotEmpty &&
        controllerDesc.text.isNotEmpty) {
      buttonState.accept(true);
    } else {
      buttonState.accept(false);
    }
  }

  void uploadImages(List<String> images) async {
    placeImages.addAll(images);
    galleryState.accept(placeImages);
  }

  void deleteImage(String image) async {
    placeImages.remove(image);
    galleryState.accept(placeImages);
  }

  void addNewPlace() async {
    placeState.loading();
    // debugPrint('addNewPlace start');
    // await Future.delayed(Duration(seconds: 5));

    final imagesUrls = await placeInteractor.uploadPlaceImages(placeImages);
    final placeType =
        Category.getCategoryByName(controllerCat.text.toLowerCase()).type;
    final newPlace = Place(
      lat: double.parse(controllerLat.text),
      lng: double.parse(controllerLng.text),
      name: controllerName.text,
      placeType: placeType,
      description: controllerDesc.text,
      urls: imagesUrls,
    );

    subscribeHandleError<dynamic>(
      placeInteractor.addNewPlace(newPlace),
      (response) {
        placeState.content(response);
        debugPrint('content push');
      },
      onError: (error) {
        placeState.error();
      },
    );
    // debugPrint('addNewPlace end');
  }
}
