import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class OrderInfoCard extends StatelessWidget {
  final String title;
  final String primaryText;
  final String? secondaryText;

  const OrderInfoCard({
    super.key,
    required this.title,
    required this.primaryText,
    this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.getCard(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.getBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.font11SemiBold(context).copyWith(
              letterSpacing: 1.2,
              color: ColorManager.getTextMuted(context),
            ),
          ),
          Gap(10.h),
          Text(
            primaryText,
            style: TextStyles.font14SemiBold(context),
          ),
          if (secondaryText != null && secondaryText!.isNotEmpty) ...[
            Gap(4.h),
            Text(
              secondaryText!,
              style: TextStyles.font13Regular(context).copyWith(
                color: ColorManager.getTextMuted(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
