import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_category_screen.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/sight_gallery.dart';
import 'package:places/ui/widgets/add_sight_screen/new_sight_app_bar.dart';

PlaceInteractor placeInteractor = PlaceInteractor();

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
                    'ГАЛЕРЕЯ',
                    style: TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 24),
                  SightGallery(),
                  const SizedBox(height: 24),
                  const Text(
                    'КАТЕГОРИЯ',
                    style: TextStyle(color: myLightSecondaryTwo),
                  ),
                  const SizedBox(height: 5),
                  _CategoryField(
                    controllerCat: _controllerCat,
                    notifyParent: () {
                      refresh();
                    },
                    setValue: (id) {
                      setCategory(id);
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'НАЗВАНИЕ',
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
                    'ОПИСАНИЕ',
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

  void setCategory(int id) {
    setState(
      () {
        _controllerCat.text = mocks[id].placeType;
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
        'Указать на карте',
        style: TextStyle(
          color: Theme.of(context).buttonColor,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _CategoryField extends StatefulWidget {
  final TextEditingController controllerCat;
  final Function() notifyParent;
  final Function(int id) setValue;

  const _CategoryField({
    Key? key,
    required this.controllerCat,
    required this.notifyParent,
    required this.setValue,
  }) : super(key: key);

  @override
  __CategoryFieldState createState() => __CategoryFieldState();
}

class __CategoryFieldState extends State<_CategoryField> {
  int? categoryid;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: 'Не выбрано',
        hintStyle: const TextStyle(
          color: myLightSecondaryTwo,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: IconButton(
          onPressed: () async {
            categoryid = await Navigator.push<int>(
              context,
              MaterialPageRoute(
                builder: (context) => SightCategoryScreen(),
              ),
            );
            setState(() {
              widget.controllerCat.text = mocks[categoryid!].placeType;
            });
          },
          icon: const Icon(Icons.navigate_next_rounded),
          color: myLightMain,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).buttonColor.withOpacity(0.4),
            width: 2.0,
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
    Key? key,
    required this.formKey,
    required this.focusNodeLat,
    required this.controllerName,
    required this.notifyParent,
  }) : super(key: key);

  @override
  _NameFieldState createState() => _NameFieldState();
}

class _NameFieldState extends State<_NameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (String value) {
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
      cursorColor: myLightMain,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).buttonColor.withOpacity(0.4),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).buttonColor.withOpacity(0.4),
            width: 2.0,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            widget.controllerName.clear();
            setState(() {
              widget.notifyParent();
            });
          },
          icon: SvgPicture.asset(
            iconClearField,
            height: 20,
            width: 20,
            color: widget.controllerName.text.isNotEmpty
                ? myLightMain
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
    Key? key,
    required this.focusNodeLat,
    required this.focusNodeLng,
    required this.focusNodeDesc,
    required this.controllerLat,
    required this.controllerLng,
    required this.notifyParent,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ШИРОТА',
                style: TextStyle(color: myLightSecondaryTwo),
              ),
              const SizedBox(height: 12),
              TextFormField(
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(widget.focusNodeLng);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Введите значение широты';
                  }
                },
                onChanged: (value) {
                  setState(() {
                    widget.notifyParent();
                  });
                },
                focusNode: widget.focusNodeLat,
                textInputAction: TextInputAction.next,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                controller: widget.controllerLat,
                cursorColor: myLightMain,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).buttonColor.withOpacity(0.4),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).buttonColor.withOpacity(0.4),
                      width: 2.0,
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
                          ? myLightMain
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
                'ДОЛГОТА',
                style: TextStyle(color: myLightSecondaryTwo),
              ),
              const SizedBox(height: 12),
              TextFormField(
                focusNode: widget.focusNodeLng,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(widget.focusNodeDesc);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Введите значение долготы';
                  }
                },
                onChanged: (value) {
                  setState(() {
                    widget.notifyParent();
                  });
                },
                textInputAction: TextInputAction.next,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                controller: widget.controllerLng,
                cursorColor: myLightMain,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).buttonColor.withOpacity(0.4),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).buttonColor.withOpacity(0.4),
                      width: 2.0,
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
                          ? myLightMain
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
    Key? key,
    required this.focusNode,
    required this.notifyParent,
    required this.controllerDesc,
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
      cursorColor: myLightMain,
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
          borderSide: BorderSide(
            color: Theme.of(context).buttonColor.withOpacity(0.4),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).buttonColor.withOpacity(0.4),
            width: 2.0,
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
    Key? key,
    required this.enable,
    required this.formKey,
    required this.controllerCat,
    required this.controllerName,
    required this.controllerLat,
    required this.controllerLng,
    required this.controllerDesc,
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
          placeInteractor.addNewPlace(
            Place(
              id: 99999,
              name: widget.controllerName.text,
              lat: double.parse(widget.controllerLat.text),
              lon: double.parse(widget.controllerLng.text),
              urls: [''],
              description: widget.controllerDesc.text,
              placeType: widget.controllerCat.text,
            ),
          );
        }
      },
      child: Text(
        'СОЗДАТЬ',
        style: TextStyle(
          color: widget.enable
              ? Colors.white
              : myLightSecondaryTwo.withOpacity(0.56),
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.enable ? Theme.of(context).buttonColor : myLightBackground,
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
