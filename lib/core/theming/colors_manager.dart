import 'package:flutter/material.dart';

class ColorManager {
  // Brand Palette (Design Tokens)
  static const Color olive = Color(0xFF3D4A2F); // Main / Primary
  static const Color ink = Color(0xFF1F2417); // Secondary
  static const Color cream = Color(0xFFFAF5EC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color sage = Color(0xFFB4B7A3);
  static const Color orange = Color(0xFFCA511D);
  static const Color muted = Color(0xFF909387);
  static const Color line = Color(0x141F2417); // rgba(31, 36, 23, .08)

  // Primary & Secondary Aliases
  static const Color primary = olive;
  static const Color secondary = ink;

  // Backgrounds
  static const Color backgroundLight = Color(0xFFE8E4DA);
  static const Color backgroundDark = Color(0xFF14170F);

  // Surfaces & Cards
  static const Color surfaceLight = cream;
  static const Color surfaceDark = Color(0xFF1B2014);
  static const Color cardLight = surfaceLight;
  static const Color cardDark = surfaceDark;

  // Borders
  static const Color borderLight = Color(0x141F2417);
  static const Color borderDark = Color(0x26FAF5EC);

  // Text
  static const Color textLight = ink;
  static const Color textDark = cream;

  // Contextual Helpers
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color getBackground(BuildContext context) =>
      isDark(context) ? backgroundDark : backgroundLight;

  static Color getSurface(BuildContext context) =>
      isDark(context) ? surfaceDark : surfaceLight;

  static Color getCard(BuildContext context) => getSurface(context);

  static Color getBorder(BuildContext context) =>
      isDark(context) ? borderDark : borderLight;

  static Color getText(BuildContext context) =>
      isDark(context) ? textDark : textLight;

  static Color getTextMuted(BuildContext context) =>
      isDark(context) ? sage : muted;
}
