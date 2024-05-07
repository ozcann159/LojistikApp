import 'package:flutter/material.dart';

final Color primaryColor = const Color(0xFF07bff); // Ana renk
final Color secondaryColor = const Color(0xFF28a745);
const Color scaffolBackgroundColor = Colors.white;
const Color textColor = Colors.white;

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: scaffolBackgroundColor,
  textTheme: TextTheme(
    bodySmall: TextStyle(color: textColor),
    bodyMedium: TextStyle(color: textColor),
  ),
);
