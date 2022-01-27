import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  cardColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: myLightBackground,
  primaryColorLight: myLightSecondaryTwo.withOpacity(0),
  errorColor: myLightRed,
  secondaryHeaderColor: myLightMain,
  iconTheme: const IconThemeData(color: myLightMain),
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
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
    primaryVariant: myLightGreen,
    primary: myLightBackground,
  ),
);

final darkTheme = ThemeData(
  iconTheme: const IconThemeData(color: Colors.white),
  cardColor: myLightSecondaryOne,
  scaffoldBackgroundColor: nightRider,
  primaryColor: myDark,
  errorColor: myDarkRed,
  primaryColorLight: myDarkSecondaryTwo.withOpacity(0.2),
  secondaryHeaderColor: Colors.white,
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
  sliderTheme: SliderThemeData(
    trackHeight: 1,
    activeTrackColor: myDarkGreen,
    inactiveTrackColor: myLightSecondaryTwo.withOpacity(0.56),
    thumbColor: Colors.white,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: myDarkMain,
    primaryVariant: myDarkGreen,
    primary: myLightBackground,
  ),
);
