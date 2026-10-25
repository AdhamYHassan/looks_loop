import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CheckoutSubNavBar extends StatelessWidget {
  final VoidCallback onBack;

  const CheckoutSubNavBar({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              LucideIcons.arrowLeft,
              color: ColorManager.getText(context),
              size: 20.sp,
            ),
            onPressed: onBack,
          ),
          SizedBox(width: 14.w),
          Text(
            'CHECKOUT',
            style: TextStyles.font16WhiteBold.copyWith(
              color: ColorManager.getText(context),
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
