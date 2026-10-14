import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/helpers/app_formatters.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class CartStickyCta extends StatelessWidget {
  final double total;
  final VoidCallback onCheckout;

  const CartStickyCta({
    super.key,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: ColorManager.getSurface(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            offset: const Offset(0, -4),
            blurRadius: 12,
          ),
        ],
        border: Border(
          top: BorderSide(
            color: ColorManager.getBorder(context),
            width: 1.w,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL',
                  style: TextStyles.font11Eyebrow(context).copyWith(
                    fontSize: 10.sp,
                    letterSpacing: 1.2,
                  ),
                ),
                Gap(2.h),
                Text(
                  '${AppFormatters.amount(total)} EGP',
                  style: TextStyles.font16WhiteBold.copyWith(
                    color: ColorManager.getText(context),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Gap(20.w),
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                  onPressed: onCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.olive,
                    foregroundColor: ColorManager.cream,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                  child: Text(
                    'PROCEED TO CHECKOUT',
                    style: TextStyles.font11Action(context).copyWith(
                      color: ColorManager.cream,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
