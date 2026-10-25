import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CheckoutAddAddressButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CheckoutAddAddressButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorManager.getText(context),
          side: BorderSide(color: ColorManager.getBorder(context)),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        icon: Icon(LucideIcons.plus, size: 16.sp),
        label: Text(
          'ADD NEW ADDRESS',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
