import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screens/add_place_screen.dart';

class AddPlaceButton extends StatelessWidget {
  const AddPlaceButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [myLightYellow, myLightGreen]),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPlaceScreen(),
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
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize: MaterialStateProperty.all(const Size(180, 48)),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}
