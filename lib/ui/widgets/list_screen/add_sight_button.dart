import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/add_sight_screen.dart';

class AddSightButton extends StatelessWidget {
  const AddSightButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [myLightYellow, myLightGreen]),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push<List>(
            context,
            MaterialPageRoute(
              builder: (context) => AddSightScreen(),
            ),
          );
          },
          child: Row(
            children: [
              SvgPicture.asset(
                iconPlus,
                height: 16,
                width: 16,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              const Text(
                'НОВОЕ МЕСТО',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.transparent),
            minimumSize: MaterialStateProperty.all(const Size(180, 48)),
            shadowColor:
                MaterialStateProperty.all(Colors.transparent),
          ),
        ),
      ),
    );
  }
}
