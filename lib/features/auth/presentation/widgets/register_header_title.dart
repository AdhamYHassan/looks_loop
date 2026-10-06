import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Editorial header title & subtitle for the complete profile screen.
class RegisterHeaderTitle extends StatelessWidget {
  const RegisterHeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'auth.complete_profile'.tr(),
          style: TextStyle(
            color: ColorManager.backgroundDark,
            fontSize: 30.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: 1.15,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'auth.complete_profile_sub'.tr(),
          style: TextStyle(
            color: ColorManager.getTextMuted(context),
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w500,
            height: 1.35,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}
