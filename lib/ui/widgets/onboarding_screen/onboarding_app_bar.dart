import 'package:flutter/material.dart';
import 'package:places/ui/screens/main_screen.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:places/ui/screens/settings_screen.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double currentPage;
  final bool fromSettings;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  const OnboardingAppBar({
    required this.currentPage,
    required this.fromSettings,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        if (currentPage != 2)
          TextButton(
            onPressed: () {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute(
                  builder: (context) => fromSettings
                      ? const SettingsScreen()
                      : const MainScreen(),
                ),
              );
            },
            child: Text(
              constants.textBtnSkip,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
