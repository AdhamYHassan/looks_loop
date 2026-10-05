import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CategorySubNavBar extends StatelessWidget {
  final String title;
  final int bagCount;
  final VoidCallback? onBackTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onBagTap;

  const CategorySubNavBar({
    super.key,
    required this.title,
    this.bagCount = 3,
    this.onBackTap,
    this.onSearchTap,
    this.onBagTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      color: ColorManager.ink,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              LucideIcons.arrowLeft,
              color: ColorManager.cream,
              size: 20.sp,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.h),
            onPressed: onBackTap ?? () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyles.font16WhiteBlack.copyWith(
                letterSpacing: 2.0,
                fontSize: 14.sp,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  LucideIcons.search,
                  color: ColorManager.cream,
                  size: 18.sp,
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.h),
                onPressed: onSearchTap,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: Icon(
                      LucideIcons.shoppingBag,
                      color: ColorManager.cream,
                      size: 18.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: 36.w,
                      minHeight: 36.h,
                    ),
                    onPressed: onBagTap,
                  ),
                  if (bagCount > 0)
                    Positioned(
                      top: 4.h,
                      right: 4.w,
                      child: Container(
                        padding: EdgeInsets.all(3.r),
                        decoration: const BoxDecoration(
                          color: ColorManager.orange,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 15.w,
                          minHeight: 15.h,
                        ),
                        child: Text(
                          '$bagCount',
                          style: TextStyles.font10DiscountBadge.copyWith(
                            fontSize: 9.sp,
                            height: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
