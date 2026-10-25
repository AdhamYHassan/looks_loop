import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/checkout/domain/entities/checkout_step.dart';

class CheckoutProgressBar extends StatelessWidget {
  final CheckoutStep currentStep;

  const CheckoutProgressBar({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final steps = CheckoutStep.values;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      color: ColorManager.getBackground(context),
      child: Row(
        children: [
          for (var i = 0; i < steps.length; i++) ...[
            _buildStepItem(context, steps[i]),
            if (i < steps.length - 1)
              Expanded(
                child: Container(
                  height: 1.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  color: steps[i].isDone(currentStep)
                      ? ColorManager.olive
                      : ColorManager.getBorder(context),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepItem(BuildContext context, CheckoutStep step) {
    final isDone = step.isDone(currentStep);
    final isActive = step.isActive(currentStep);
    final textColor = (isDone || isActive)
        ? ColorManager.getText(context)
        : ColorManager.getTextMuted(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isActive)
          Container(
            width: 14.w,
            height: 5.h,
            margin: EdgeInsets.only(right: 4.w),
            decoration: BoxDecoration(
              color: ColorManager.olive,
              borderRadius: BorderRadius.circular(2.5.r),
            ),
          )
        else
          Container(
            width: 6.w,
            height: 6.w,
            margin: EdgeInsets.only(right: 4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isDone ? ColorManager.olive : ColorManager.getBorder(context),
            ),
          ),
        Text(
          step.label,
          maxLines: 1,
          style: TextStyle(
            fontSize: 9.sp,
            fontWeight:
                (isActive || isDone) ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0.4,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
