import 'package:flutter/material.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/screens/main_screen.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: myLightGreen,
        fixedSize: const Size(328, 48),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'НА СТАРТ',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
