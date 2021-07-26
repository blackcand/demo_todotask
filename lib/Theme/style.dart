import 'package:flutter/material.dart';
import 'package:tasks/Theme/colors.dart';

final ThemeData appTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: backgroundColor,
  primaryColor: mainColor,
  accentColor: mainColor,
  appBarTheme: AppBarTheme(
    color: transparentColor,
    elevation: 0.0,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 18.0, color: darkColor),
    subtitle1: TextStyle(color: darkColor, fontSize: 14.0),
    bodyText1: TextStyle(fontSize: 14.0, color: darkColor),
    bodyText2: TextStyle(
      color: blackColor,
      fontSize: 16.0,
    ),
    button: TextStyle(
      fontSize: 24.0,
      color: backgroundColor,
    ),
    headline2: TextStyle(fontSize: 18.0, color: disabledTextColor),
  ),
);
