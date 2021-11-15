import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screens/add_sight_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:places/ui/screens/res/icons.dart';

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
              builder: (context) => const AddSightScreen(),
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
              Text(
                constants.textNewPlace.toUpperCase(),
                style: const TextStyle(
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
