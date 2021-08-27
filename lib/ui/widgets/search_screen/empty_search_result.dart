import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';

class EmptySearchResult extends StatelessWidget {
  const EmptySearchResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            iconSearch,
            height: 70,
            color: myLightSecondaryTwo,
          ),
          SizedBox(height: 32),
          Text(
            'Ничего не найдено.',
            style: TextStyle(
              fontSize: 18,
              color: myLightSecondaryTwo.withOpacity(0.56),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Попробуйте изменить параметры\nпоиска',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: myLightSecondaryTwo.withOpacity(0.56),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}