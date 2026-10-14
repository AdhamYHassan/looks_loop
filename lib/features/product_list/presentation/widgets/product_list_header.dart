import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductListHeader extends StatelessWidget {
  final String categoryTitle;
  final String subcategoryTitle;
  final int count;

  const ProductListHeader({
    super.key,
    required this.categoryTitle,
    required this.subcategoryTitle,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                categoryTitle.toUpperCase(),
                style: TextStyles.font11Eyebrow(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorManager.getTextMuted(context),
                  letterSpacing: 1.1,
                ),
              ),
              Gap(6.w),
              Icon(
                LucideIcons.chevronRight,
                size: 11.sp,
                color: ColorManager.getTextMuted(context),
              ),
              Gap(6.w),
              Text(
                subcategoryTitle.toUpperCase(),
                style: TextStyles.font11Eyebrow(context).copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorManager.getText(context),
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          Gap(6.h),
          Text(
            subcategoryTitle.toUpperCase(),
            style: TextStyles.font20Bold(context).copyWith(
              fontSize: 24.sp,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w800,
            ),
          ),
          Gap(4.h),
          Text(
            '$count ITEMS',
            style: TextStyles.font11Eyebrow(context).copyWith(
              color: ColorManager.getTextMuted(context),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
