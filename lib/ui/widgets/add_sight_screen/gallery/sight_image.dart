import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screens/res/icons.dart';

class SightImage extends StatelessWidget {
  final Function(String imgUrl) deleteImage;
  final String image;
  const SightImage({
    required this.image,
    required this.deleteImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                child: Image.file(
                  File(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: InkWell(
                onTap: () {
                  deleteImage(image);
                },
                child: SvgPicture.asset(
                  iconCloseRound,
                  width: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
