import 'package:flutter/material.dart';
import 'package:addrive/app_config/app_config.dart' as config;
import 'package:addrive/app_config/app_config.dart';

class AppTheme {
  final lightTheme = ThemeData(
    primaryColor: CustomColors().mainColor(1),
    iconTheme: IconThemeData(color: CustomColors().mainColor(1)),
    brightness: Brightness.light,
    cardColor: const Color(0xffE7E8EA),
    canvasColor: Colors.black,
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.white,
        onPrimary: const Color(0xff3c3c43).withOpacity(0.5),
        inversePrimary: const Color(0xffB5B5B5),
        secondary: Colors.transparent,
        onSecondary: Colors.transparent,
        error: Colors.transparent,
        onError: Colors.transparent,
        surface: Colors.transparent,
        onSurface: Colors.transparent),
    shadowColor: const Color(0xffC7C7CC),
    dividerColor: const Color(0xff004646),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffCCCFD3), width: 1)),
        contentPadding: const EdgeInsets.only(left: 12),
        filled: true,
        hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xffB1B1B4),
            fontWeight: FontWeight.w400),
        fillColor: const Color(0xffFFFFFF),
        constraints: const BoxConstraints(maxHeight: 80, minHeight: 44),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffCCCFD3), width: 1),
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffCCCFD3), width: 1),
            borderRadius: BorderRadius.circular(8))),
    cardTheme: const CardTheme(color: Color(0xffE7E8EA)),
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    // appBarTheme: AppBarTheme(color: CustomColors().mainColor(1)),
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
    fontFamily: "Inter",
    hintColor: config.CustomColors().secondColor(1),
    textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 22.0,
            color: config.CustomColors().mainColor(1),
            fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xff3c3c43).withOpacity(0.6)),
        bodyLarge: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
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
        labelMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: config.CustomColors().greyColor(1)),
        bodySmall: TextStyle(
            fontSize: 12.0, color: config.CustomColors().accentColor(1)),
        labelLarge: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
  );

  final darkTheme = ThemeData(
    fontFamily: 'Inter',
    primaryColor: const Color(0xFF252525),
    iconTheme: const IconThemeData(color: Colors.white),
    brightness: Brightness.dark,
    cardColor: const Color(0xff3D3D3D),
    canvasColor: Colors.white,
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff474747),
        onPrimary: Colors.transparent,
        secondary: Colors.transparent,
        onSecondary: Colors.transparent,
        error: Colors.transparent,
        onError: Colors.transparent,
        surface: Colors.transparent,
        onSurface: Colors.transparent),
    cardTheme: const CardTheme(color: Color(0xff3D3D3D)),
    scaffoldBackgroundColor: const Color(0xFF2C2C2C),
    hintColor: config.CustomColors().secondDarkColor(1),
    focusColor: config.CustomColors().accentDarkColor(1),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 20.0, color: config.CustomColors().secondDarkColor(1)),
      headlineSmall: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff3c3c43)),
      bodyLarge: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
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
