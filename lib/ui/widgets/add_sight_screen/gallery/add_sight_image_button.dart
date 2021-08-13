import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';

class AddSightImageButton extends StatelessWidget {
  const AddSightImageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            border: Border.all(
              color: lightGreen.withOpacity(0.56),
            ),
          ),
        ),
        SvgPicture.asset(
          iconPlus,
          width: 25,
          color: lightGreen,
        ),
      ],
    );
  }
}
