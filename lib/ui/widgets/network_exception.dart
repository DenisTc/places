import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as Constants;
import 'package:places/ui/screens/res/icons.dart';

class NetworkException extends StatelessWidget {
  const NetworkException({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconErrorRound,
          height: 64,
          width: 64,
          color: myLightSecondaryTwo.withOpacity(0.56),
        ),
        const SizedBox(height: 24),
        const Text(
          Constants.textError,
          style: TextStyle(
            color: myLightSecondaryTwo,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          Constants.textTryLater,
          style: TextStyle(
            color: myLightSecondaryTwo,
          ),
        ),
      ],
    );
  }
}
