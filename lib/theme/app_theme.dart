import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: const Color(0xFF353F54),
      onPrimary: Colors.white,
      secondary: const Color(0xFF222834),
      onSecondary: Colors.white,
      error: Colors.red.shade900,
      onError: Colors.white,
      surface: const Color(0xFF353F54),
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF242C3B),
  );
}
