import 'package:flutter/material.dart';

class ResponsiveHelper {
  ResponsiveHelper._();

  static const double tabletBreakpoint = 600.0;
  static const double desktopBreakpoint = 1024.0;
  static const double maxContentWidth = 1140.0;

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tabletBreakpoint;
  }

  static bool isLandscapeTablet(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width >= desktopBreakpoint && size.width > size.height;
  }

  static double getContentPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return 32.0;
    if (width >= tabletBreakpoint) return 24.0;
    return 16.0;
  }

  static int getGridCrossAxisCount(
    BuildContext context, {
    int phone = 2,
    int tablet = 3,
    int desktop = 4,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return desktop;
    if (width >= tabletBreakpoint) return tablet;
    return phone;
  }
}

