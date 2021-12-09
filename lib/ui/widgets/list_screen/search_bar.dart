import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/redux/action/filtered_places_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/domain/search_filter.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_search_screen.dart';

class SearchBar extends StatefulWidget {
  final textFieldFocusNode = FocusNode();

  SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  SearchFilter? settingsFilter;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        if (widget.textFieldFocusNode.canRequestFocus) {
          Navigator.push<List>(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SightSearchScreen(settingsFilter: settingsFilter),
            ),
          );
        }
      },
      enabled: true,
      readOnly: true,
      enableInteractiveSelection: false,
      focusNode: widget.textFieldFocusNode,
      cursorColor: myLightMain,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.zero,
        fillColor: Theme.of(context).primaryColor,
        hintText: 'Поиск',
        hintStyle: const TextStyle(
          color: myLightSecondaryTwo,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: IconButton(
          onPressed: null,
          icon: SvgPicture.asset(
            iconSearch,
            height: 20,
            width: 20,
            color: myLightSecondaryTwo.withOpacity(0.56),
          ),
        ),
        suffixIcon: Material(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          clipBehavior: Clip.antiAlias,
          child: GestureDetector(
            child: IconButton(
              icon: SvgPicture.asset(
                iconOptions,
                height: 15,
                width: 15,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
              onPressed: () {
                widget.textFieldFocusNode.unfocus();
                widget.textFieldFocusNode.canRequestFocus = false;
                _navigateGetDataFromFilters(context);
                Future.delayed(const Duration(milliseconds: 100), () {
                  widget.textFieldFocusNode.canRequestFocus = true;
                });
              },
            ),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Future<void> _navigateGetDataFromFilters(BuildContext context) async {
    settingsFilter = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FiltersScreen(),
      ),
    );

    StoreProvider.of<AppState>(context).dispatch(LoadFilteredPlacesAction());
  }
}
