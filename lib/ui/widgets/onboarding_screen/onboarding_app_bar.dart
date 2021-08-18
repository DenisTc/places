import 'package:flutter/material.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/screens/sight_list_screen.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnboardingAppBar({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  final double currentPage;
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        if (currentPage != 2)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil<SightListScreen>(
                    context,
                    MaterialPageRoute(builder: (context) => SightListScreen()),
                    ModalRoute.withName('/Home'),
                  );
                },
                child: const Text(
                  'Пропустить',
                  style: TextStyle(
                    color: lightGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}