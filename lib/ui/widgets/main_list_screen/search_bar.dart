import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/sight_search_screen.dart';

class SearchBar extends StatefulWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);
  final textFieldFocusNode = FocusNode();
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //final textFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        if (widget.textFieldFocusNode.canRequestFocus) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SightSearchScreen()));
        }
      },
      enabled: true,
      readOnly: true,
      enableInteractiveSelection: false,
      focusNode: widget.textFieldFocusNode,
      cursorColor: favoriteColor,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.all(0),
        fillColor: whiteSmoke,
        hintText: 'Поиск',
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
            width: 20,
            color: textColorSecondary.withOpacity(0.56),
          ),
        ),
        suffixIcon: GestureDetector(
          child: IconButton(
            icon: SvgPicture.asset(
              iconOptions,
              height: 15,
              width: 15,
              color: lightGreen,
            ),
            onPressed: () {
              widget.textFieldFocusNode.unfocus();
              widget.textFieldFocusNode.canRequestFocus = false;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FiltersScreen()));
              Future.delayed(Duration(milliseconds: 100), () {
                widget.textFieldFocusNode.canRequestFocus = true;
              });
            },
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 1,
            color: whiteSmoke,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 1,
            color: whiteSmoke,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 1,
            color: whiteSmoke,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 1,
            color: whiteSmoke,
          ),
        ),
      ),
    );
  }
}
