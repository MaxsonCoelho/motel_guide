import 'package:flutter/material.dart';

class AppTheme {
  // Cores principais
  static const Color primaryColor = Color.fromARGB(255, 255, 17, 0);
  static const Color secondaryColor = Color.fromARGB(255, 183, 28, 28);
  static const Color backgroundColor = Colors.white;

  // Definição do tema claro
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyText1: TextStyle(fontSize: 16, color: Colors.black),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
  );

  // Definição do tema escuro
  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.red[700]!,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyText1: TextStyle(fontSize: 16, color: Colors.white),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  );
}
