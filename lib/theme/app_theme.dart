import 'package:flutter/material.dart';

class AppTheme {
  static const String _whiteColor = "#E8DFCA";
  static const String _nvColor = "#4F6F52";
  
  static Color whiteColor = Color(int.parse(_whiteColor.replaceAll('#', '0xff')));
  static Color nvColor = Color(int.parse(_nvColor.replaceAll('#', '0xff')));
  static Color backgroundColor = const Color(0xFF121212);  
  static final ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      color: nvColor,
      iconTheme: IconThemeData(color: whiteColor),
      toolbarTextStyle: TextStyle(
        color: whiteColor,
        fontSize: 20,
      ),
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: whiteColor),
      bodyMedium: TextStyle(color: whiteColor),
      displayLarge: TextStyle(color: whiteColor),
      displayMedium: TextStyle(color: whiteColor),
      displaySmall: TextStyle(color: whiteColor),
      headlineMedium: TextStyle(color: whiteColor),
      headlineSmall: TextStyle(color: whiteColor),
      titleLarge: TextStyle(color: whiteColor),
      titleMedium: TextStyle(color: whiteColor),
      titleSmall: TextStyle(color: whiteColor),
    ),
    iconTheme: IconThemeData(color: whiteColor),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: nvColor),
  );
}
