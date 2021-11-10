import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as Constants;

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
      title: Text(
        Constants.textNewPlace,
        style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
      ),
      leadingWidth: 100,
      leading: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          Constants.textCancel,
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
