import 'package:flutter/material.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/styles.dart';

final lightTheme = ThemeData(
  accentColor: whiteSmoke,
  textTheme: TextTheme(
    headline1: mainText,
    bodyText1: cardTextDesc.copyWith(color: textColorPrimary),
    subtitle1: cardTextType.copyWith(color: textColorPrimary, fontWeight: FontWeight.w700),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: favoriteColor,
    unselectedItemColor: favoriteColor,
  ),
);

final darkTheme = ThemeData(
  iconTheme: IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: nightRider,
  accentColor: blackRussian,
  primaryTextTheme: TextTheme(headline6: mainText),
  textTheme: TextTheme(
    headline1: mainText.copyWith(color: Colors.white),
    bodyText1: cardTextDesc.copyWith(color: Colors.white),
    bodyText2: cardTextShortDesc,
    subtitle1: cardTextType.copyWith(color: textColorSecondary, fontWeight: FontWeight.w700),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: blackRussian,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
  ),
);
