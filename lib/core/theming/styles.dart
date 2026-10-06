import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class TextStyles {
  TextStyles._();

  static const String cairo = 'Cairo';

  static TextStyle _style(
    double size, {
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) =>
      TextStyle(
        fontFamily: cairo,
        fontSize: size.sp,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
      );

  // --- Display & Hero Headings ---
  static TextStyle font32SemiBold(BuildContext c) =>
      _style(32, weight: FontWeight.w600, letterSpacing: -0.5, color: ColorManager.getText(c));

  static TextStyle font32WhiteBlack =
      _style(32, weight: FontWeight.w900, height: 1.05, letterSpacing: -0.5, color: Colors.white);

  static TextStyle font28WhiteBlack =
      _style(28, weight: FontWeight.w900, height: 1.1, letterSpacing: -0.3, color: Colors.white);

  static TextStyle font26CreamBlack =
      _style(26, weight: FontWeight.w900, letterSpacing: -0.3, color: ColorManager.cream);

  static TextStyle font26TextBlack(BuildContext c) =>
      _style(26, weight: FontWeight.w900, letterSpacing: 0.5, color: ColorManager.getText(c));

  // --- Titles & Cards ---
  static TextStyle font20Bold(BuildContext c) =>
      _style(20, weight: FontWeight.w900, letterSpacing: -0.3, color: ColorManager.getText(c));

  static TextStyle font18SemiBold(BuildContext c) =>
      _style(18, weight: FontWeight.w600, letterSpacing: -0.3, color: ColorManager.getText(c));

  static TextStyle font14SemiBold(BuildContext c) =>
      _style(14, weight: FontWeight.w600, color: ColorManager.getText(c));

  static TextStyle font14Medium(BuildContext c) =>
      _style(14, weight: FontWeight.w500, color: ColorManager.getText(c));

  static TextStyle font14Regular(BuildContext c) =>
      _style(14, weight: FontWeight.w400, color: ColorManager.getText(c));

  static TextStyle font13Regular(BuildContext c) =>
      _style(13, weight: FontWeight.w400, color: ColorManager.getText(c));

  static TextStyle font13Medium(BuildContext c) =>
      _style(13, weight: FontWeight.w500, color: ColorManager.getText(c));

  static TextStyle font12Regular(BuildContext c) =>
      _style(12, weight: FontWeight.w400, color: ColorManager.getText(c));

  static TextStyle font12Medium(BuildContext c) =>
      _style(12, weight: FontWeight.w500, color: ColorManager.getText(c));

  static TextStyle font11SemiBold(BuildContext c) =>
      _style(11, weight: FontWeight.w600, color: ColorManager.getText(c));

  static TextStyle font22WhiteSemiBold =
      _style(22, weight: FontWeight.w600, letterSpacing: -0.4, color: Colors.white);

  static TextStyle font16WhiteSemiBold =
      _style(16, weight: FontWeight.w600, letterSpacing: -0.3, color: Colors.white);

  static TextStyle font16WhiteBold =
      _style(16, weight: FontWeight.bold, color: Colors.white);

  static TextStyle font16WhiteBlack =
      _style(16, weight: FontWeight.w900, letterSpacing: 1.5, color: Colors.white);

  static TextStyle font15WhiteBold =
      _style(15, weight: FontWeight.bold, color: Colors.white);

  static TextStyle font14WhiteMedium =
      _style(14, weight: FontWeight.w500, color: Colors.white);

  static TextStyle font13TextBold(BuildContext c) =>
      _style(13, weight: FontWeight.w700, color: ColorManager.getText(c));

  static TextStyle font13WhiteBlack =
      _style(13, weight: FontWeight.w900, letterSpacing: 1.1, color: Colors.white);

  static TextStyle font12WhiteBlack =
      _style(12, weight: FontWeight.w900, letterSpacing: 1.1, color: Colors.white);

  static TextStyle font13White70Regular =
      _style(13, height: 1.35, color: Colors.white70);

  static TextStyle font13MutedMedium(BuildContext c) =>
      _style(13, weight: FontWeight.w500, color: ColorManager.getTextMuted(c));

  // --- Labels, Badges & Actions ---
  static TextStyle font12Brand(BuildContext c) =>
      _style(12, weight: FontWeight.w800, letterSpacing: 1.5, color: ColorManager.getText(c));

  static TextStyle font12Price(BuildContext c, {bool isDiscounted = false}) =>
      _style(12, weight: FontWeight.w800, color: isDiscounted ? ColorManager.orange : ColorManager.getText(c));

  static TextStyle font11Action(BuildContext c) =>
      _style(11, weight: FontWeight.w700, letterSpacing: 1.1, color: ColorManager.getText(c));

  static TextStyle font11Eyebrow(BuildContext c) =>
      _style(11, weight: FontWeight.w700, letterSpacing: 1.4, color: ColorManager.getTextMuted(c));

  static TextStyle font11WhiteEyebrow =
      _style(11, weight: FontWeight.w700, letterSpacing: 2.0, color: Colors.white70);

  static TextStyle font11BlackCta =
      _style(11, weight: FontWeight.w800, letterSpacing: 1.1, color: Colors.black);

  static TextStyle font11OrangeEyebrow =
      _style(12, weight: FontWeight.w800, letterSpacing: 2.2, color: ColorManager.orange);

  static TextStyle font11SageSemiBold =
      _style(11, weight: FontWeight.w600, letterSpacing: 1.4, color: ColorManager.sage);

  static TextStyle font11MutedLineThrough(BuildContext c) =>
      _style(11, decoration: TextDecoration.lineThrough, color: ColorManager.getTextMuted(c));

  // --- Badges & Micro Typography ---
  static TextStyle font10WhiteMedium =
      _style(10, weight: FontWeight.w500, color: Colors.white70);

  static TextStyle font10DiscountBadge =
      _style(10, weight: FontWeight.bold, color: ColorManager.cream);

  static TextStyle font9NavLabel({required bool isActive, required Color color}) =>
      _style(9, letterSpacing: 0.8, weight: isActive ? FontWeight.w800 : FontWeight.w600, color: color);

  static TextStyle font8Announcement =
      _style(8, weight: FontWeight.w600, letterSpacing: 2.0, color: ColorManager.cream);
}
