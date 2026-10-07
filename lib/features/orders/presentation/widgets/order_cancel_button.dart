import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class OrderCancelButton extends StatelessWidget {
  final VoidCallback? onCancelTap;

  const OrderCancelButton({super.key, this.onCancelTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        onPressed: onCancelTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: ColorManager.orange.withValues(alpha: 0.35),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          'orders.cancel_order'.tr(),
          style: TextStyles.font14SemiBold(context).copyWith(
            color: ColorManager.orange,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
