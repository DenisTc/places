import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/colors.dart';

class NewSightAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewSightAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text('Новое место'),
      leadingWidth: 100,
      leading: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Отмена',
          style: TextStyle(
            color: myLightSecondaryTwo,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
