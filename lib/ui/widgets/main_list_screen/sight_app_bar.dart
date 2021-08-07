import 'package:flutter/material.dart';

class SightAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SightAppBar();

  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 56,
      title: Text(
        'Список интересных мест',
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
