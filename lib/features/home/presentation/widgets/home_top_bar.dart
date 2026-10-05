import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeTopBar extends StatelessWidget {
  final int bagCount;
  final VoidCallback? onSearchTap;
  final VoidCallback? onBagTap;
  final VoidCallback? onLoaderTap;

  const HomeTopBar({
    super.key,
    this.bagCount = 3,
    this.onSearchTap,
    this.onBagTap,
    this.onLoaderTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57.h,
      color: ColorManager.ink,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          Row(
            children: [
              if (onLoaderTap != null) ...[
                IconButton(
                  icon: Icon(
                    LucideIcons.sparkles,
                    color: ColorManager.cream,
                    size: 20.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.h),
                  onPressed: onLoaderTap,
                ),
                SizedBox(width: 8.w),
              ],
              IconButton(
                icon: Icon(
                  LucideIcons.search,
                  color: ColorManager.cream,
                  size: 20.sp,
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.h),
                onPressed: onSearchTap,
              ),
              SizedBox(width: 8.w),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: Icon(
                      LucideIcons.shoppingBag,
                      color: ColorManager.cream,
                      size: 20.sp,
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
                          style: TextStyles.font10DiscountBadge.copyWith(fontSize: 9.sp, height: 1),
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

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/app_logo.png',
      height: 24.h,
      fit: BoxFit.contain,
      color: ColorManager.cream,
    );
  }
}
