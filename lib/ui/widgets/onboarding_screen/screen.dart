import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screens/res/colors.dart';

class Screen extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const Screen({
    required this.icon,
    required this.title,
    required this.description,
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          height: 98,
          color: Theme.of(context).iconTheme.color,
        ),
        const SizedBox(height: 40),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: myLightSecondaryTwo),
        ),
      ],
    );
  }
}
