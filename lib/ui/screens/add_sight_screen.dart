import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  late FocusNode nodeLat = FocusNode();
  late FocusNode nodeLng = FocusNode();
  late FocusNode nodeDesc = FocusNode();
  late bool _isButtonEnabled = false;

  late GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _controllerCat = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerLat = TextEditingController();
  final _controllerLng = TextEditingController();
  final _controllerDesc = TextEditingController();

  refresh() {
    setState(
      () {
        if ( //_controllerCat.text.isNotEmpty &&
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Новое место'),
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {},
          child: Text(
            'Отмена',
            style: TextStyle(
              color: textColorSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Категория'.toUpperCase(),
                  style: TextStyle(color: textColorSecondary),
                ),
                const SizedBox(height: 5),
                _CategoryField(
                  controllerCat: _controllerCat,
                  notifyParent: () {
                    refresh();
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Название'.toUpperCase(),
                  style: TextStyle(color: textColorSecondary),
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
                _SelectOnMapButton(),
                const SizedBox(height: 30),
                Text(
                  'Описание'.toUpperCase(),
                  style: TextStyle(color: textColorSecondary),
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
      ),
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
          color: lightGreen,
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
    Key? key,
    required this.controllerCat,
    required this.notifyParent,
  }) : super(key: key);

  @override
  __CategoryFieldState createState() => __CategoryFieldState();
}

class __CategoryFieldState extends State<_CategoryField> {
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
      //controller: widget.controllerCat,
      initialValue: 'Кафе',
      readOnly: true,
      textInputAction: TextInputAction.next,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: 'Не выбрано',
        hintStyle: TextStyle(
            color: textColorSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.navigate_next_rounded),
          color: favoriteColor,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: lightGreen.withOpacity(0.4), width: 2.0),
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
      cursorColor: favoriteColor,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: lightGreen.withOpacity(0.4), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: lightGreen.withOpacity(0.4), width: 2.0),
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
                ? favoriteColor
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
              Text(
                'Широта'.toUpperCase(),
                style: TextStyle(color: textColorSecondary),
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
                keyboardType: TextInputType.numberWithOptions(signed: true),
                controller: widget.controllerLat,
                cursorColor: favoriteColor,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: lightGreen.withOpacity(0.4), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: lightGreen.withOpacity(0.4), width: 2.0),
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
                          ? favoriteColor
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Долгота'.toUpperCase(),
                style: TextStyle(color: textColorSecondary),
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
                keyboardType: TextInputType.numberWithOptions(signed: true),
                controller: widget.controllerLng,
                cursorColor: favoriteColor,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: lightGreen.withOpacity(0.4), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: lightGreen.withOpacity(0.4), width: 2.0),
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
                          ? favoriteColor
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
      cursorColor: favoriteColor,
      decoration: InputDecoration(
        hintText: 'введите текст',
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textColorSecondary,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: lightGreen.withOpacity(0.4), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: lightGreen.withOpacity(0.4), width: 2.0),
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
          mocks.add(
            Sight(
              widget.controllerName.text,
              double.parse(widget.controllerLat.text),
              double.parse(widget.controllerLng.text),
              '',
              widget.controllerDesc.text,
              widget.controllerCat.text,
            ),
          );
        }
      },
      child: Text(
        'Создать'.toUpperCase(),
        style: TextStyle(
          color: widget.enable
              ? Colors.white
              : textColorSecondary.withOpacity(0.56),
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(widget.enable ? lightGreen : whiteSmoke),
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 48)),
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
