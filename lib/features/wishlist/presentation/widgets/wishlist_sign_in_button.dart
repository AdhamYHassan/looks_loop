import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class WishlistSignInButton extends StatelessWidget {
  const WishlistSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.ink,
          foregroundColor: ColorManager.cream,
          padding: EdgeInsets.symmetric(horizontal: 34.w),
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
        onPressed: () => context.push(Routes.login),
        child: Text(
          'Sign in',
          style: TextStyle(
            fontSize: 16.5.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.33,
            color: ColorManager.cream,
          ),
        ),
      ),
    );
  }
}
