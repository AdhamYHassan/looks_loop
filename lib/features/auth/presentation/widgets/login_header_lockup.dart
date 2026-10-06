import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/loaders/chasing_loop_loader.dart';

/// Top horizontal brand lockup containing the ChasingLoopLoader
/// and the LookLoops wordmark side-by-side.
class LoginHeaderLockup extends StatelessWidget {
  const LoginHeaderLockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ChasingLoopLoader(
          size: 42.w,
          color: ColorManager.cream,
        ),
        SizedBox(width: 10.w),
        Image.asset(
          'assets/images/lookloops.png',
          height: 38.h,
          fit: BoxFit.contain,
          color: ColorManager.cream,
        ),
      ],
    );
  }
}
