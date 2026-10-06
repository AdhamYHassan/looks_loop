import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_animated_tagline.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_header_lockup.dart';

/// Olive hero area containing brand lockup, headline, and animated tagline.
class LoginHero extends StatelessWidget {
  const LoginHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorManager.olive,
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 20.h),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoginHeaderLockup(),
            SizedBox(height: 16.h),

            const LoginAnimatedTagline(),
          ],
        ),
      ),
    );
  }
}
