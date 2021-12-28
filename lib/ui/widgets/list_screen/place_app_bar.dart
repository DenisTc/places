import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;

class PlaceAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  const PlaceAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 56,
      iconTheme: Theme.of(context).iconTheme,
      title: Text(
        constants.textListPlaces,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
