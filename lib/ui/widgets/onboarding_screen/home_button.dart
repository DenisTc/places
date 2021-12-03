import 'package:flutter/material.dart';
import 'package:places/ui/screens/main_screen.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:places/ui/screens/settings_screen.dart';

class HomeButton extends StatelessWidget {
  final bool fromSettings;
  const HomeButton({
    required this.fromSettings,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) =>
                fromSettings ? const SettingsScreen() : const MainScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.primaryVariant,
        fixedSize: const Size(328, 48),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        constants.textBtnStart,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
