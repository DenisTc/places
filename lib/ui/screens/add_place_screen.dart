import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/blocs/place/bloc/place_bloc.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screens/location_screen.dart';
import 'package:places/ui/screens/place_category_screen.dart';
import 'package:places/ui/widgets/add_place_screen/gallery/place_gallery.dart';
import 'package:places/ui/widgets/add_place_screen/new_place_app_bar.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddPlaceScreen> {
  final _controllerCat = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerLat = TextEditingController();
  final _controllerLng = TextEditingController();
  final _controllerDesc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode latFocusNode = FocusNode();
  FocusNode lngFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  bool _isButtonEnabled = false;
  List<String> images = [];

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
                    images: images,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    constants.textCategory.toUpperCase(),
                    style: const TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 5),
                  _CategoryField(
                    controllerCat: _controllerCat,
                    checkFieldFills: () {
                      checkFieldFills();
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    constants.textTitle,
                    style: TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 12),
                  _NameField(
                    formKey: _formKey,
                    focusNodeLat: nameFocusNode,
                    controllerName: _controllerName,
                    checkFieldFills: () {
                      checkFieldFills();
                    },
                  ),
                  const SizedBox(height: 24),
                  _CoordinatesFields(
                    focusNodeLat: latFocusNode,
                    focusNodeLng: lngFocusNode,
                    focusNodeDesc: descFocusNode,
                    controllerLat: _controllerLat,
                    controllerLng: _controllerLng,
                    checkFieldFills: () {
                      checkFieldFills();
                    },
                  ),
                   _SelectOnMapButton(controllerLat: _controllerLat,
                    controllerLng: _controllerLng,),
                  const SizedBox(height: 30),
                  const Text(
                    constants.textDescription,
                    style: TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 12),
                  _DescriptionField(
                    focusNode: descFocusNode,
                    controllerDesc: _controllerDesc,
                    checkFieldFills: () {
                      checkFieldFills();
                    },
                  ),
                  const SizedBox(height: 50),
                  _CreatePlaceButton(
                    buttonState: _isButtonEnabled,
                    formKey: _formKey,
                    images: images,
                    newPlace: Place(
                      id: null,
                      name: _controllerName.text,
                      lat: _controllerLat.text.isNotEmpty
                          ? double.parse(_controllerLat.text)
                          : 0.0,
                      lng: _controllerLng.text.isNotEmpty
                          ? double.parse(_controllerLng.text)
                          : 0.0,
                      urls: const [''],
                      description: _controllerDesc.text,
                      placeType: _controllerCat.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkFieldFills() {
    setState(
      () {
        if (_controllerCat.text.isNotEmpty &&
            _controllerName.text.isNotEmpty &&
            _controllerLat.text.isNotEmpty &&
            _controllerLng.text.isNotEmpty &&
            _controllerDesc.text.isNotEmpty) {
          _isButtonEnabled = true;
        } else {
          _isButtonEnabled = false;
        }
      },
    );
  }

  void deleteImage(String imgUrl) {
    setState(() {
      images.remove(imgUrl);
    });
  }

  void addImage(List<XFile>? xFileList) {
    setState(() {
      images.addAll(xFileList!.map((image) => image.path));
    });
  }
}

class _SelectOnMapButton extends StatelessWidget {
  final TextEditingController controllerLat;
  final TextEditingController controllerLng;
  const _SelectOnMapButton({
    Key? key,
    required this.controllerLat,
    required this.controllerLng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final Location location = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LocationScreen(),
          ),
        );
        controllerLat.text = location.lat.toString();
        controllerLng.text = location.lng.toString();
      },
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
  final Function() checkFieldFills;

  const _CategoryField({
    Key? key,
    required this.controllerCat,
    required this.checkFieldFills,
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
            widget.checkFieldFills();
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
  final Function() checkFieldFills;

  const _NameField({
    Key? key,
    required this.formKey,
    required this.focusNodeLat,
    required this.controllerName,
    required this.checkFieldFills,
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
        setState(() {
          widget.checkFieldFills();
        });
      },
      controller: widget.controllerName,
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
  final Function() checkFieldFills;

  const _CoordinatesFields({
    required this.focusNodeLat,
    required this.focusNodeLng,
    required this.focusNodeDesc,
    required this.controllerLat,
    required this.controllerLng,
    required this.checkFieldFills,
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
                  setState(() {
                    widget.checkFieldFills();
                  });
                },
                focusNode: widget.focusNodeLat,
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
                  setState(() {
                    widget.checkFieldFills();
                  });
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
  final Function() checkFieldFills;

  const _DescriptionField({
    required this.focusNode,
    required this.controllerDesc,
    required this.checkFieldFills,
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
        setState(() {
          widget.checkFieldFills();
        });
      },
      controller: widget.controllerDesc,
      focusNode: widget.focusNode,
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
  final bool buttonState;
  final GlobalKey<FormState> formKey;
  final Place newPlace;
  final List<String> images;

  const _CreatePlaceButton({
    Key? key,
    required this.buttonState,
    required this.formKey,
    required this.newPlace,
    required this.images,
  }) : super(key: key);

  @override
  _CreatePlaceButtonState createState() => _CreatePlaceButtonState();
}

class _CreatePlaceButtonState extends State<_CreatePlaceButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.buttonState
          ? () {
              BlocProvider.of<PlaceBloc>(context).add(
                AddNewPlace(
                  place: widget.newPlace,
                  images: widget.images,
                ),
              );

              showAlertDialog(context);
            }
          : null,
      child: Text(
        constants.textBtnCreate,
        style: TextStyle(
          color: widget.buttonState
              ? Colors.white
              : myLightSecondaryTwo.withOpacity(0.56),
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.buttonState
              ? Theme.of(context).colorScheme.primaryVariant
              : Theme.of(context).primaryColor,
        ),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          return AlertDialog(
            scrollable: true,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            content: Row(
              children: [
                state is AddNewPlaceInProcess
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primaryVariant,
                      )
                    : SizedBox.shrink(),
                state is AddNewPlaceError
                    ? Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 50.0,
                      )
                    : SizedBox.shrink(),
                state is AddNewPlaceSuccess
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primaryVariant,
                        size: 50.0,
                      )
                    : SizedBox.shrink(),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Builder(
                      builder: (context) {
                        if (state is AddNewPlaceSuccess) {
                          debugPrint(constants.textAddNewPlaceSuccess);
                          Future.delayed(const Duration(seconds: 2)).then(
                            (_) => Navigator.pop(context),
                          );
                        }
                        if (state is AddNewPlaceError) {
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ],
                          );
                        }

                        if (state is AddNewPlaceSuccess) {
                          return const Text(constants.textAddNewPlaceSuccess);
                        }
                        return const Text(constants.textAddNewPlaceInProcess);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  ).whenComplete(() => Navigator.pop(context));
}
