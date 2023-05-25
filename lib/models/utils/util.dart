import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.black,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.black,
      ),
    ),
  );
  static ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepPurple,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
