import 'package:checklist/app/shared/theme/color_schemes.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: lightColorScheme.primary,
          actionsIconTheme: IconThemeData(color: lightColorScheme.onPrimary),
          iconTheme: IconThemeData(color: lightColorScheme.onPrimary),
          titleTextStyle: TextStyle(
            color: lightColorScheme.onPrimary,
            fontSize: 24,
          )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: lightColorScheme.onPrimary,
        backgroundColor: lightColorScheme.primary,
      ),
      colorScheme: lightColorScheme);

  final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(
            color: darkColorScheme.onPrimary,
          ),
          iconTheme: IconThemeData(color: darkColorScheme.onPrimary),
          centerTitle: true,
          color: darkColorScheme.primary,
          titleTextStyle: TextStyle(
            color: darkColorScheme.onPrimary,
            fontSize: 24,
          )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: darkColorScheme.onPrimary,
        backgroundColor: darkColorScheme.primary,
      ),
      colorScheme: darkColorScheme);
}
