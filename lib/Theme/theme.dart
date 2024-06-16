import 'package:flutter/material.dart';

// Light theme
final lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: const Color(0xFF323232),
  canvasColor: Colors.lightBlueAccent,
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black54),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.lightBlueAccent,
    textTheme: ButtonTextTheme.primary,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  dividerColor: Colors.black,
);

// Dark theme
final darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF323232),
  scaffoldBackgroundColor: Colors.black,
  canvasColor: Colors.blueAccent,
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blueAccent,
    textTheme: ButtonTextTheme.primary,
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  dividerColor: Colors.white,
);
