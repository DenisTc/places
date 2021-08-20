import 'package:flutter/material.dart';

class SightAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  const SightAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 56,
      title: Text(
        'Список интересных мест',
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
