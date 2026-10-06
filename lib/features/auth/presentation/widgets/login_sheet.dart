import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Editorial sheet sliding up from bottom with signature asymmetric curve.
class LoginSheet extends StatelessWidget {
  final Widget child;

  const LoginSheet({super.key, required this.child});

  static const Duration _slideDuration = Duration(milliseconds: 750);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: 0.0),
      duration: _slideDuration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) =>
          Transform.translate(offset: Offset(0, 100.h * value), child: child),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
        decoration: BoxDecoration(
          color: ColorManager.getSurface(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(52.r),
            topRight: Radius.circular(14.r),
          ),
        ),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
