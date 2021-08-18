import 'package:flutter/material.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/screens/sight_list_screen.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil<SightListScreen>(
          context,
          MaterialPageRoute(builder: (context) => SightListScreen()),
          ModalRoute.withName('/Home'),
        );
      },
      child: Container(
        height: 48,
        width: 328,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: lightGreen,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'НА СТАРТ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}