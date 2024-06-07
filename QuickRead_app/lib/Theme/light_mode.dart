import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.red.shade200,
    onPrimary: Colors.black,
    secondary: Colors.red.shade400,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.grey.shade300,
    onBackground: Colors.black,
    surface: Colors.grey.shade100,
    onSurface: Colors.black,
    primaryContainer: Colors.red.shade300,
    secondaryContainer: Colors.red.shade400,
    inversePrimary: Colors.red.shade800,
    outline: Colors.red.shade600,
    surfaceTint: Colors.red.shade100,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
);
