import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/blocs/place/bloc/place_bloc.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_category_screen.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/sight_gallery.dart';
import 'package:places/ui/widgets/add_sight_screen/new_sight_app_bar.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final _controllerCat = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerLat = TextEditingController();
  final _controllerLng = TextEditingController();
  final _controllerDesc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late FocusNode nodeLat = FocusNode();
  late FocusNode nodeLng = FocusNode();
  late FocusNode nodeDesc = FocusNode();
  late bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NewSightAppBar(),
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
                  const SightGallery(),
                  const SizedBox(height: 24),
                  Text(
                    constants.textCategory.toUpperCase(),
                    style: const TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 5),
                  _CategoryField(
                    controllerCat: _controllerCat,
                    notifyParent: () {
                      refresh();
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
                    focusNodeLat: nodeLat,
                    controllerName: _controllerName,
                    notifyParent: () {
                      refresh();
                    },
                  ),
                  const SizedBox(height: 24),
                  _CoordinatesFields(
                    focusNodeLat: nodeLat,
                    focusNodeLng: nodeLng,
                    focusNodeDesc: nodeDesc,
                    controllerLat: _controllerLat,
                    controllerLng: _controllerLng,
                    notifyParent: () {
                      refresh();
                    },
                  ),
                  const _SelectOnMapButton(),
                  const SizedBox(height: 30),
                  const Text(
                    constants.textDescription,
                    style: TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 12),
                  _DescriptionField(
                    focusNode: nodeDesc,
                    notifyParent: () {
                      refresh();
                    },
                    controllerDesc: _controllerDesc,
                  ),
                  const SizedBox(height: 50),
                  _CreateSightButton(
                    enable: _isButtonEnabled,
                    formKey: _formKey,
                    controllerCat: _controllerCat,
                    controllerName: _controllerName,
                    controllerDesc: _controllerDesc,
                    controllerLat: _controllerLat,
                    controllerLng: _controllerLng,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
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
  final Function() notifyParent;

  const _CategoryField({
    required this.controllerCat,
    required this.notifyParent,
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
            builder: (context) => SightCategoryScreen(selectedCategory),
          ),
        );
        if (selectedCategory != null) {
          setState(() {
            widget.controllerCat.text =
                Category.getCategoryByType(selectedCategory!).name;
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Выберите категорию';
        }
      },
      onChanged: (value) {
        setState(() {
          widget.notifyParent();
        });
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
        hintText: 'Не выбрано',
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
}

class _NameField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerName;
  final FocusNode focusNodeLat;
  final Function() notifyParent;

  const _NameField({
    required this.formKey,
    required this.focusNodeLat,
    required this.controllerName,
    required this.notifyParent,
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
          return 'Введите название места';
        }
      },
      onChanged: (value) {
        setState(() {
          widget.notifyParent();
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
            setState(() {
              widget.notifyParent();
            });
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
  final Function() notifyParent;

  const _CoordinatesFields({
    required this.focusNodeLat,
    required this.focusNodeLng,
    required this.focusNodeDesc,
    required this.controllerLat,
    required this.controllerLng,
    required this.notifyParent,
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
                    widget.notifyParent();
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
                          ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                          : Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.controllerLat.text.isNotEmpty
                          ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                          : Colors.grey,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      widget.controllerLat.clear();
                      setState(() {
                        widget.notifyParent();
                      });
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
                    widget.notifyParent();
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
                          ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                          : Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.controllerLng.text.isNotEmpty
                          ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.4)
                          : Colors.grey,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      widget.controllerLng.clear();
                      setState(() {
                        widget.notifyParent();
                      });
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
  final Function() notifyParent;

  const _DescriptionField({
    required this.focusNode,
    required this.notifyParent,
    required this.controllerDesc,
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
          return 'Заполните описание';
        }
      },
      onChanged: (value) {
        setState(() {
          widget.notifyParent();
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
        hintText: 'введите текст',
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

class _CreateSightButton extends StatefulWidget {
  final bool enable;
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerCat;
  final TextEditingController controllerName;
  final TextEditingController controllerLat;
  final TextEditingController controllerLng;
  final TextEditingController controllerDesc;

  const _CreateSightButton({
    required this.enable,
    required this.formKey,
    required this.controllerCat,
    required this.controllerName,
    required this.controllerLat,
    required this.controllerLng,
    required this.controllerDesc,
    Key? key,
  }) : super(key: key);

  @override
  _CreateSightButtonState createState() => _CreateSightButtonState();
}

class _CreateSightButtonState extends State<_CreateSightButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.formKey.currentState!.validate() && widget.enable) {
          final placeType =
              Category.getCategoryByName(widget.controllerCat.text).type;
          final newPlace = Place(
            id: 0,
            name: widget.controllerName.text,
            lat: double.parse(widget.controllerLat.text),
            lng: double.parse(widget.controllerLng.text),
            urls: const [''],
            description: widget.controllerDesc.text,
            placeType: placeType,
          );

          BlocProvider.of<PlaceBloc>(context).add(AddNewPlace(newPlace));

          showAlertDialog(context);
        }
      },
      child: Text(
        constants.textBtnCreate,
        style: TextStyle(
          color: widget.enable
              ? Colors.white
              : myLightSecondaryTwo.withOpacity(0.56),
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.enable
              ? Theme.of(context).colorScheme.primaryVariant
              : Theme.of(context).primaryColor,
        ),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<PlaceBloc, PlaceState>(builder: (context, state) {
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
                  child: Builder(builder: (context) {
                    if (state is AddNewPlaceSuccess) {
                      debugPrint('Место успешно добавлено!');
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
                                color: Theme.of(context).colorScheme.primaryVariant,
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
                    }

                    if (state is AddNewPlaceSuccess) {
                      return const Text(constants.textAddNewPlaceSuccess);
                    }
                    return const Text(constants.textAddNewPlaceInProcess);
                  }),
                ),
              ),
            ],
          ),
        );
      });
    },
  ).whenComplete(() => Navigator.pop(context));
}
