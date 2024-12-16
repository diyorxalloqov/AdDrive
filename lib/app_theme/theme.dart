import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/app_config/app_config.dart' as config;
import 'package:flutter_texi_tracker/app_config/app_config.dart';

class AppTheme {
  final lightTheme = ThemeData(
    primaryColor: CustomColors().mainColor(1),
    iconTheme: IconThemeData(color: CustomColors().mainColor(1)),
    brightness: Brightness.light,
    cardColor: const Color(0xffE7E8EA),
    canvasColor: Colors.black,
    cardTheme: const CardTheme(color: Color(0xffE7E8EA)),
    scaffoldBackgroundColor: const Color(0xffF0F1F3),
    appBarTheme: AppBarTheme(color: CustomColors().mainColor(1)),
    primarySwatch: const MaterialColor(
      0xFF041E48,
      <int, Color>{
        50: Color(0xFF041E48),
        100: Color(0xFF041E48),
        200: Color(0xFF041E48),
        300: Color(0xFF041E48),
        400: Color(0xFF041E48),
        500: Color(0xFF041E48),
        600: Color(0xFF041E48),
        700: Color(0xFF041E48),
        800: Color(0xFF041E48),
        900: Color(0xFF041E48),
      },
    ),
    focusColor: config.CustomColors().secondColor(1),
    primaryIconTheme: IconThemeData(
      color: CustomColors().mainColor(1),
    ),
    hintColor: config.CustomColors().secondColor(1),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 22.0,
        color: config.CustomColors().mainColor(1),
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: config.CustomColors().mainColor(1)),
      displaySmall: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: config.CustomColors().mainColor(1)),
      headlineLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: config.CustomColors().mainColor(1)),
      headlineMedium: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w300,
          color: config.CustomColors().mainColor(1)),
      titleLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: config.CustomColors().secondColor(1)),
      titleMedium: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
          color: config.CustomColors().secondColor(1)),
      bodySmall: TextStyle(
          fontSize: 12.0, color: config.CustomColors().accentColor(1)),
    ),
  );

  final darkTheme = ThemeData(
    fontFamily: 'NunitoSans',
    primaryColor: const Color(0xFF252525),
    iconTheme: const IconThemeData(color: Colors.white),
    brightness: Brightness.dark,
    cardColor: const Color(0xff3D3D3D),
    canvasColor: Colors.white,
    cardTheme: const CardTheme(color: Color(0xff3D3D3D)),
    scaffoldBackgroundColor: const Color(0xFF2C2C2C),
    hintColor: config.CustomColors().secondDarkColor(1),
    focusColor: config.CustomColors().accentDarkColor(1),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 20.0, color: config.CustomColors().secondDarkColor(1)),
      displayMedium: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: config.CustomColors().secondDarkColor(1)),
      displaySmall: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: config.CustomColors().secondDarkColor(1)),
      headlineLarge: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          color: config.CustomColors().mainDarkColor(1)),
      headlineMedium: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w300,
          color: config.CustomColors().secondDarkColor(1)),
      titleLarge: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: config.CustomColors().secondDarkColor(1)),
      titleMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: config.CustomColors().mainDarkColor(1)),
      bodySmall: TextStyle(
          fontSize: 12.0, color: config.CustomColors().secondDarkColor(0.6)),
    ),
  );
}
