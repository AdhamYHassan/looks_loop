import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductListToolbar extends StatelessWidget {
  final int activeFilterCount;
  final VoidCallback onFilterTap;
  final VoidCallback onSortTap;

  const ProductListToolbar({
    super.key,
    required this.activeFilterCount,
    required this.onFilterTap,
    required this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorManager.getBorder(context), width: 1.h),
          bottom: BorderSide(color: ColorManager.getBorder(context), width: 1.h),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onFilterTap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.slidersHorizontal,
                      size: 14.sp,
                      color: ColorManager.getText(context),
                    ),
                    Gap(8.w),
                    Text(
                      'FILTER',
                      style: TextStyles.font11Eyebrow(context).copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    if (activeFilterCount > 0) ...[
                      Gap(6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.ink,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '$activeFilterCount',
                          style: TextStyles.font10DiscountBadge.copyWith(
                            fontSize: 9.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 24.h,
            color: ColorManager.getBorder(context),
          ),
          Expanded(
            child: InkWell(
              onTap: onSortTap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.arrowDownUp,
                      size: 14.sp,
                      color: ColorManager.getText(context),
                    ),
                    Gap(8.w),
                    Text(
                      'SORT',
                      style: TextStyles.font11Eyebrow(context).copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
