import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/loaders/chasing_loop_loader.dart';
import 'package:looks_loop/features/auth/presentation/widgets/animated_arrow_icon.dart';

/// Editorial primary CTA styled with asymmetric rounded corners,
/// animated nudge arrow icon, and smooth loading loop state.
class LoginSubmitButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  const LoginSubmitButton({
    super.key,
    required this.label,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.ink,
          foregroundColor: ColorManager.cream,
          disabledBackgroundColor: ColorManager.ink.withValues(alpha: 0.38),
          disabledForegroundColor: ColorManager.cream.withValues(alpha: 0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.r),
              topRight: Radius.circular(18.r),
              bottomRight: Radius.circular(18.r),
              bottomLeft: Radius.circular(6.r),
            ),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: isLoading
              ? ChasingLoopLoader(
                  key: const ValueKey('loading'),
                  size: 24.w,
                  color: ColorManager.cream,
                )
              : Row(
                  key: const ValueKey('label'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: ColorManager.cream,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    const AnimatedArrowIcon(),
                  ],
                ),
        ),
      ),
    );
  }
}
