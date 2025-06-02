import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFFC107), // Vibrant yellow (lightbulb/gears)
      onPrimary: Color(0xFF000000), // Black for contrast on yellow
      secondary: Color(0xFF2196F3), // Bright blue (planet/lightbulb)
      onSecondary: Color(0xFFFFFFFF), // White for text/icons on blue
      error: Color(0xFFB00020), // Standard red error color
      onError: Color(0xFFFFFFFF), // White text on error
      surface: Color(0xFFFFFFFF), // Background content area (paper white)
      onSurface: Color(0xFF212121), // Dark grey for text on surface
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFC107), // Vibrant yellow (lightbulb/gears)
      onPrimary: Color(0xFF000000), // Black for contrast on yellow
      secondary: Color(0xFF2196F3), // Bright blue (planet/lightbulb)
      onSecondary: Color(0xFFFFFFFF), // White for text/icons on blue
      error: Color(0xFFB00020), // Standard red error color
      onError: Color(0xFFFFFFFF), // White text on error
      surface: Color(0xFFFFFFFF), // Background content area (paper white)
      onSurface: Color(0xFF212121), // Dark grey for text on surface
    ),
  );
}

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black54,
      fontSize: 57,
      height: 64,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black54,
      fontSize: 45,
      height: 52,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black54,
      fontSize: 36,
      height: 44,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black54,
      fontSize: 32,
      height: 40,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black54,
      fontSize: 28,
      height: 36,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black87,
      fontSize: 24,
      height: 28,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black87,
      fontSize: 22,
      height: 28,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black87,
      fontSize: 16,
      height: 24,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 14,
      height: 20,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black87,
      fontSize: 16,
      height: 24,
      letterSpacing: 0.15,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black87,
      fontSize: 14,
      height: 20,
      letterSpacing: 0.25,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black54,
      fontSize: 12,
      height: 16,
      letterSpacing: 0.4,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black87,
      fontSize: 14,
      height: 20,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 12,
      height: 16,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 11,
      height: 16,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white70,
      fontSize: 57,
      height: 64,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white70,
      fontSize: 45,
      height: 52,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white70,
      fontSize: 36,
      height: 44,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white70,
      fontSize: 32,
      height: 40,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white70,
      fontSize: 28,
      height: 36,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 24,
      height: 28,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 22,
      height: 28,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 16,
      height: 24,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 14,
      height: 20,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 16,
      height: 24,
      letterSpacing: 0.15,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 14,
      height: 20,
      letterSpacing: 0.25,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white70,
      fontSize: 12,
      height: 16,
      letterSpacing: 0.4,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 14,
      height: 20,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 12,
      height: 16,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 11,
      height: 16,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
  );
}
