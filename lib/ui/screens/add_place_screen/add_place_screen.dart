import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/category.dart';
import 'package:places/ui/screens/add_place_screen/add_place_screen_wm.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/place_category_screen/place_category_screen.dart';
import 'package:places/ui/widgets/add_place_screen/gallery/place_gallery.dart';
import 'package:places/ui/widgets/add_place_screen/new_place_app_bar.dart';
import 'package:relation/relation.dart';

class AddPlaceScreen extends CoreMwwmWidget<AddPlaceScreenWidgetModel> {
  const AddPlaceScreen({
    WidgetModelBuilder? widgetModelBuilder,
  }) : super(widgetModelBuilder: AddPlaceScreenWidgetModel.builder);

  @override
  WidgetState<CoreMwwmWidget<AddPlaceScreenWidgetModel>,
      AddPlaceScreenWidgetModel> createWidgetState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState
    extends WidgetState<AddPlaceScreen, AddPlaceScreenWidgetModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NewPlaceAppBar(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    constants.textGallery,
                    style: TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 24),
                  PlaceGallery(
                    addImage: (List<XFile>? xFileList) {
                      addImage(xFileList);
                    },
                    deleteImage: (String imgUrl) {
                      deleteImage(imgUrl);
                    },
                    galleryState: wm.galleryState,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    constants.textCategory.toUpperCase(),
                    style: const TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 5),
                  _CategoryField(
                    controllerCat: wm.controllerCat,
                    fillFilds: wm.checkFields,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    constants.textTitle,
                    style: TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 12),
                  _NameField(
                    formKey: _formKey,
                    focusNodeLat: wm.nameFocusNode,
                    controllerName: wm.controllerName,
                    fillFilds: wm.checkFields,
                  ),
                  const SizedBox(height: 24),
                  _CoordinatesFields(
                    focusNodeLat: wm.latFocusNode,
                    focusNodeLng: wm.lngFocusNode,
                    focusNodeDesc: wm.descFocusNode,
                    controllerLat: wm.controllerLat,
                    controllerLng: wm.controllerLng,
                    fillFilds: wm.checkFields,
                  ),
                  const _SelectOnMapButton(),
                  const SizedBox(height: 30),
                  const Text(
                    constants.textDescription,
                    style: TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 12),
                  _DescriptionField(
                    focusNode: wm.descFocusNode,
                    controllerDesc: wm.controllerDesc,
                    fillFilds: wm.checkFields,
                  ),
                  const SizedBox(height: 50),
                  _CreatePlaceButton(
                    buttonState: wm.buttonState,
                    formKey: _formKey,
                    placeState: wm.placeState,
                    addPlace: () {
                      wm.addNewPlace();
                    },
                    uploadImages: (images) {
                      wm.uploadImages(images);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  void deleteImage(String imgUrl) {
    wm.deleteImage(imgUrl);
  }

  void addImage(List<XFile>? xFileList) {
    final List<String> images = xFileList!.map((image) => image.path).toList();
    wm.uploadImages(images);
  }
}

class _SelectOnMapButton extends StatelessWidget {
  const _SelectOnMapButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        constants.textBtnShowOnMap,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primaryVariant,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _CategoryField extends StatefulWidget {
  final TextEditingController controllerCat;
  final Function() fillFilds;

  const _CategoryField({
    required this.controllerCat,
    required this.fillFilds,
    Key? key,
  }) : super(key: key);

  @override
  __CategoryFieldState createState() => __CategoryFieldState();
}

class __CategoryFieldState extends State<_CategoryField> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        selectedCategory = await Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceCategoryScreen(selectedCategory),
          ),
        );
        if (selectedCategory != null) {
          setState(() {
            widget.controllerCat.text =
                capitalize(Category.getCategoryByType(selectedCategory!).name);
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return constants.textSelectCategory;
        }
      },
      onChanged: (value) {
        setState(() {});
      },
      controller: widget.controllerCat,
      onEditingComplete: widget.fillFilds(),
      readOnly: true,
      textInputAction: TextInputAction.next,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).secondaryHeaderColor,
      ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        hintText: constants.textNotSelected,
        hintStyle: const TextStyle(
          color: myLightSecondaryTwo,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: Icon(
          Icons.navigate_next_rounded,
          size: 32,
          color: Theme.of(context).secondaryHeaderColor,
        ),
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: widget.controllerCat.text.isNotEmpty
                ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                : Colors.grey,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: widget.controllerCat.text.isNotEmpty
                ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                : Colors.grey,
          ),
        ),
      ),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}

class _NameField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerName;
  final FocusNode focusNodeLat;
  final Function() fillFilds;

  const _NameField({
    required this.formKey,
    required this.focusNodeLat,
    required this.controllerName,
    required this.fillFilds,
    Key? key,
  }) : super(key: key);

  @override
  _NameFieldState createState() => _NameFieldState();
}

class _NameFieldState extends State<_NameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(widget.focusNodeLat);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return constants.textEnterNamePlace;
        }
      },
      onChanged: (value) {
        setState(() {});
      },
      controller: widget.controllerName,
      onEditingComplete: widget.fillFilds(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      cursorColor: Theme.of(context).secondaryHeaderColor,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).secondaryHeaderColor,
      ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: widget.controllerName.text.isNotEmpty
                ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                : Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: widget.controllerName.text.isNotEmpty
                ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                : Colors.grey,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            widget.controllerName.clear();
            setState(() {});
          },
          iconSize: 10,
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(
            iconClearField,
            height: 20,
            width: 20,
            color: widget.controllerName.text.isNotEmpty
                ? Theme.of(context).secondaryHeaderColor
                : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class _CoordinatesFields extends StatefulWidget {
  final FocusNode focusNodeLat;
  final FocusNode focusNodeLng;
  final FocusNode focusNodeDesc;
  final TextEditingController controllerLat;
  final TextEditingController controllerLng;
  final Function() fillFilds;

  const _CoordinatesFields({
    required this.focusNodeLat,
    required this.focusNodeLng,
    required this.focusNodeDesc,
    required this.controllerLat,
    required this.controllerLng,
    required this.fillFilds,
    Key? key,
  }) : super(key: key);

  @override
  __CoordinatesFieldsState createState() => __CoordinatesFieldsState();
}

class __CoordinatesFieldsState extends State<_CoordinatesFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                constants.textLatitude,
                style: TextStyle(color: myLightSecondaryTwo),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: widget.controllerLat,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(widget.focusNodeLng);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return constants.textEnterLatitude;
                  }
                },
                onChanged: (value) {
                  setState(() {});
                },
                focusNode: widget.focusNodeLat,
                onEditingComplete: widget.fillFilds(),
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[0-9.]'),
                  ),
                ],
                cursorColor: Theme.of(context).secondaryHeaderColor,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.controllerLat.text.isNotEmpty
                          ? Theme.of(context)
                              .colorScheme
                              .primaryVariant
                              .withOpacity(0.4)
                          : Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.controllerLat.text.isNotEmpty
                          ? Theme.of(context)
                              .colorScheme
                              .primaryVariant
                              .withOpacity(0.4)
                          : Colors.grey,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      widget.controllerLat.clear();
                      setState(() {});
                    },
                    icon: SvgPicture.asset(
                      iconClearField,
                      height: 20,
                      width: 20,
                      color: widget.controllerLat.text.isNotEmpty
                          ? Theme.of(context).secondaryHeaderColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                constants.textLongitude,
                style: TextStyle(color: myLightSecondaryTwo),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: widget.controllerLng,
                onEditingComplete: widget.fillFilds(),
                focusNode: widget.focusNodeLng,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(widget.focusNodeDesc);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return constants.textEnterLongitude;
                  }
                },
                onChanged: (value) {
                  setState(() {});
                },
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                textInputAction: TextInputAction.next,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[0-9.]'),
                  ),
                ],
                cursorColor: Theme.of(context).secondaryHeaderColor,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.controllerLng.text.isNotEmpty
                          ? Theme.of(context)
                              .colorScheme
                              .primaryVariant
                              .withOpacity(0.4)
                          : Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.controllerLng.text.isNotEmpty
                          ? Theme.of(context)
                              .colorScheme
                              .primaryVariant
                              .withOpacity(0.4)
                          : Colors.grey,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      widget.controllerLng.clear();
                      setState(() {});
                    },
                    icon: SvgPicture.asset(
                      iconClearField,
                      height: 20,
                      width: 20,
                      color: widget.controllerLng.text.isNotEmpty
                          ? Theme.of(context).secondaryHeaderColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DescriptionField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controllerDesc;
  final Function() fillFilds;

  const _DescriptionField({
    required this.focusNode,
    required this.controllerDesc,
    required this.fillFilds,
    Key? key,
  }) : super(key: key);

  @override
  __DescriptionFieldState createState() => __DescriptionFieldState();
}

class __DescriptionFieldState extends State<_DescriptionField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return constants.textEnterDescPlace;
        }
      },
      onChanged: (value) {
        setState(() {});
      },
      controller: widget.controllerDesc,
      focusNode: widget.focusNode,
      onEditingComplete: widget.fillFilds(),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      minLines: 4,
      maxLines: 4,
      cursorColor: Theme.of(context).secondaryHeaderColor,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).secondaryHeaderColor,
      ),
      decoration: InputDecoration(
        hintText: constants.textEnterText,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: myLightSecondaryTwo,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: widget.controllerDesc.text.isNotEmpty
                ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                : myLightSecondaryTwo.withOpacity(0.56),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: widget.controllerDesc.text.isNotEmpty
                ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                : myLightSecondaryTwo.withOpacity(0.56),
          ),
        ),
      ),
    );
  }
}

class _CreatePlaceButton extends StatefulWidget {
  final StreamedState<bool> buttonState;
  final GlobalKey<FormState> formKey;
  final Function(List<String>) uploadImages;
  final Function() addPlace;
  final EntityStreamedState placeState;

  const _CreatePlaceButton({
    required this.buttonState,
    required this.formKey,
    required this.addPlace,
    required this.placeState,
    required this.uploadImages,
    Key? key,
  }) : super(key: key);

  @override
  _CreatePlaceButtonState createState() => _CreatePlaceButtonState();
}

class _CreatePlaceButtonState extends State<_CreatePlaceButton> {
  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<bool>(
        streamedState: widget.buttonState,
        builder: (context, buttonState) {
          return ElevatedButton(
            onPressed: buttonState
                ? () {
                    widget.addPlace();
                    showAlertDialog(
                      context: context,
                      placeState: widget.placeState,
                    );
                  }
                : null,
            child: Text(
              constants.textBtnCreate,
              style: TextStyle(
                color: buttonState
                    ? Colors.white
                    : myLightSecondaryTwo.withOpacity(0.56),
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                buttonState
                    ? Theme.of(context).colorScheme.primaryVariant
                    : Theme.of(context).primaryColor,
              ),
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 48)),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          );
        });
  }
}

showAlertDialog(
    {required BuildContext context, required EntityStreamedState placeState}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: EntityStateBuilder<void>(
          streamedState: placeState,
          builder: (ctx, places) {
            Future.delayed(const Duration(seconds: 2)).then(
              (_) => Navigator.pop(context),
            );
            return Row(
              children: [
                Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primaryVariant,
                  size: 50.0,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Builder(
                      builder: (context) {
                        return const Text(constants.textAddNewPlaceSuccess);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
          loadingBuilder: (context, data) {
            return Row(
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Builder(
                      builder: (context) {
                        return const Text(constants.textAddNewPlaceInProcess);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
          loadingChild: Row(
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Builder(
                    builder: (context) {
                      return const Text(constants.textAddNewPlaceInProcess);
                    },
                  ),
                ),
              ),
            ],
          ),
          errorDataBuilder: (context, data, e) {
            return Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50.0,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            Text(constants.textAddNewPlaceError),
                            SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                constants.textBtnBackToMainScreen,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
          errorChild: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50.0,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          Text(constants.textAddNewPlaceError),
                          SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              constants.textBtnBackToMainScreen,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ).whenComplete(() => Navigator.pop(context));
}
