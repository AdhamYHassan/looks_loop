import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class AppTheme {
  static const String fontFamily = 'Cairo';

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorManager.backgroundLight,
    cardColor: ColorManager.surfaceLight,
    dividerColor: ColorManager.borderLight,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorManager.olive,
      onPrimary: ColorManager.cream,
      secondary: ColorManager.ink,
      onSecondary: ColorManager.cream,
      error: Color(0xFFBA1A1A),
      onError: ColorManager.white,
      surface: ColorManager.surfaceLight,
      onSurface: ColorManager.textLight,
      outline: ColorManager.borderLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.ink,
      foregroundColor: ColorManager.cream,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: ColorManager.textLight, fontFamily: fontFamily),
      bodyMedium: TextStyle(color: ColorManager.textLight, fontFamily: fontFamily),
      bodySmall: TextStyle(color: ColorManager.muted, fontFamily: fontFamily),
      titleLarge: TextStyle(
        color: ColorManager.textLight,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(color: ColorManager.textLight, fontFamily: fontFamily),
      titleSmall: TextStyle(color: ColorManager.muted, fontFamily: fontFamily),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorManager.backgroundDark,
    cardColor: ColorManager.surfaceDark,
    dividerColor: ColorManager.borderDark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ColorManager.olive,
      onPrimary: ColorManager.cream,
      secondary: ColorManager.sage,
      onSecondary: ColorManager.ink,
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: ColorManager.surfaceDark,
      onSurface: ColorManager.textDark,
      outline: ColorManager.borderDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.ink,
      foregroundColor: ColorManager.cream,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: ColorManager.textDark, fontFamily: fontFamily),
      bodyMedium: TextStyle(color: ColorManager.textDark, fontFamily: fontFamily),
      bodySmall: TextStyle(color: ColorManager.sage, fontFamily: fontFamily),
      titleLarge: TextStyle(
        color: ColorManager.textDark,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(color: ColorManager.textDark, fontFamily: fontFamily),
      titleSmall: TextStyle(color: ColorManager.sage, fontFamily: fontFamily),
    ),
  );
}
