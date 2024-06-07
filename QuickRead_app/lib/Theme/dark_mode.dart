import 'package:flutter/material.dart';

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.red.shade800,
    onPrimary: Colors.white,
    secondary: Colors.red.shade700,
    onSecondary: Colors.white,
    error: Colors.red.shade800,
    onError: Colors.white,
    background: Colors.black,
    onBackground: Colors.white,
    surface: Colors.grey.shade900,
    onSurface: Colors.white,
    primaryContainer: Colors.red.shade700,
    secondaryContainer: Colors.red.shade600,
    inversePrimary: Colors.red.shade300,
    outline: Colors.red.shade400,
    surfaceTint: Colors.red.shade900,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
);
