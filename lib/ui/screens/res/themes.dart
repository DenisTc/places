import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/styles.dart';


final lightTheme = ThemeData(
  accentColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: myLightBackground,
  primaryColorLight: myLightSecondaryTwo.withOpacity(0),
  errorColor: myLightRed,
  buttonColor: myLightGreen,
  textTheme: TextTheme(
    headline1: mainText,
    bodyText1: cardTextDesc.copyWith(color: myLightSecondaryOne),
    subtitle1: cardTextType.copyWith(
      color: myLightSecondaryOne,
      fontWeight: FontWeight.w700,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: myLightMain,
    unselectedItemColor: myLightMain,
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 1,
    activeTrackColor: myLightGreen,
    inactiveTrackColor: myLightSecondaryTwo.withOpacity(0.56),
    thumbColor: Colors.white,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
);

final darkTheme = ThemeData(
  iconTheme: const IconThemeData(color: Colors.white),
  accentColor: myDarkMain,
  scaffoldBackgroundColor: nightRider,
  primaryColor: myDark,
  errorColor: myDarkRed,
  primaryColorLight: myDarkSecondaryTwo.withOpacity(0.2),
  buttonColor: myDarkGreen,
  primaryTextTheme: TextTheme(headline6: mainText),
  textTheme: TextTheme(
    headline1: mainText.copyWith(color: Colors.white),
    bodyText1: cardTextDesc.copyWith(color: Colors.white),
    bodyText2: cardTextShortDesc,
    subtitle1: cardTextType.copyWith(
      color: myDarkSecondaryTwo,
      fontWeight: FontWeight.w700,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: myDarkMain,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
  ),
);
