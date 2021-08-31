import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritesEmpty extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;

  const FavoritesEmpty({
    Key? key,
    required this.icon,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 253.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: 64,
                width: 64,
                color: const Color.fromRGBO(124, 126, 146, 0.56),
              ),
              const SizedBox(height: 32),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(124, 126, 146, 0.56),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(124, 126, 146, 0.56),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}