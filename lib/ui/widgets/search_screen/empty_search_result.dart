import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/res/icons.dart';

class EmptySearchResult extends StatelessWidget {
  const EmptySearchResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconSearch,
          height: 70,
          color: myLightSecondaryTwo,
        ),
        const SizedBox(height: 32),
        Text(
          constants.textNotFound,
          style: TextStyle(
            fontSize: 18,
            color: myLightSecondaryTwo.withOpacity(0.56),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          constants.textTryChangeOptions,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: myLightSecondaryTwo.withOpacity(0.56),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}