import 'package:flutter/material.dart';
import 'package:places/ui/screens/main_screen.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double currentPage;

  const OnboardingAppBar({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

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
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            child: Text(
              'Пропустить',
              style: TextStyle(
                color: Theme.of(context).buttonColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
