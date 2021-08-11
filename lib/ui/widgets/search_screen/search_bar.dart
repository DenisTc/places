import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controllerSearch;
  final Function() notifyParent;

  const SearchBar({
    Key? key,
    required this.controllerSearch,
    required this.notifyParent,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(12.0)),
        color: whiteSmoke,
      ),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            widget.notifyParent();
          });
        },
        controller: widget.controllerSearch,
        cursorColor: favoriteColor,
        autofocus: true,
        cursorHeight: 20,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Поиск',
          contentPadding: EdgeInsets.only(top: 15),
          hintStyle: TextStyle(
            color: textColorSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: IconButton(
            onPressed: null,
            icon: SvgPicture.asset(
              iconSearch,
              height: 20,
              color: textColorSecondary.withOpacity(0.56),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              widget.controllerSearch.clear();
              setState(() {
                widget.notifyParent();
              });
            },
            icon: SvgPicture.asset(
              iconClearField,
              height: 20,
              color: widget.controllerSearch.text.isNotEmpty
                  ? favoriteColor
                  : Colors.transparent,
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
