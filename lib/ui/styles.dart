import 'package:flutter/material.dart';
import 'package:places/ui/colors.dart';

const TextStyle _text = TextStyle(
  fontFamily: "Roboto",
  fontStyle: FontStyle.normal,
);

TextStyle mainText = _text.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: textColorPrimary,
);

TextStyle cardTextTitle = _text.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

TextStyle cardTextDesc = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: textColorSecondary,
);

TextStyle cardTextShortDesc = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: textColorSecondary,
);

TextStyle cardTextType = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: textColorSecondary,
);

