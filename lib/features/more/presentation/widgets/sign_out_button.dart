import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Standalone Sign Out button displayed at the bottom of the More screen
/// for authenticated users.
class SignOutButton extends StatelessWidget {
  final VoidCallback? onSignOutTap;

  const SignOutButton({super.key, this.onSignOutTap});

  @override
  Widget build(BuildContext context) {
    const errorColor = Color(0xFFBA1A1A);
    final borderColor = ColorManager.getBorder(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        onPressed: onSignOutTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: errorColor,
          side: BorderSide(color: borderColor, width: 1.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.logOut, size: 18.sp, color: errorColor),
            Gap(8.w),
            Text(
              'auth.logout'.tr(),
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700,
                color: errorColor,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
