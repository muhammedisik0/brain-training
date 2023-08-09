import 'package:flutter/material.dart';

import 'color_constants.dart';
import 'font_constants.dart';

final theme = ThemeData(
  fontFamily: FontConstants.exo2,
  textTheme: textTheme,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedLabelStyle: textTheme.labelLarge,
    unselectedLabelStyle: textTheme.labelLarge,
    selectedItemColor: ColorConstants.purple,
    unselectedItemColor: ColorConstants.grey,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    selectedIconTheme: const IconThemeData(
      size: 24,
      color: ColorConstants.purple,
    ),
    unselectedIconTheme: const IconThemeData(
      size: 24,
      color: ColorConstants.grey,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: textTheme.titleLarge!.copyWith(
      color: Colors.black,
      fontFamily: FontConstants.exo2,
    ),
  ),
);

const textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  ),
  displayMedium: TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  ),
  displaySmall: TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  headlineLarge: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  headlineMedium: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  labelSmall: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
);
