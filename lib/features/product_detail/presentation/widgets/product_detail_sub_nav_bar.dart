import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductDetailSubNavBar extends StatelessWidget {
  final bool isWishlisted;
  final int bagCount;
  final VoidCallback onBackTap;
  final VoidCallback onWishlistTap;
  final VoidCallback onBagTap;

  const ProductDetailSubNavBar({
    super.key,
    required this.isWishlisted,
    required this.bagCount,
    required this.onBackTap,
    required this.onWishlistTap,
    required this.onBagTap,
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
            constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
            onPressed: onBackTap,
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : LucideIcons.heart,
              color: isWishlisted ? Colors.redAccent : ColorManager.cream,
              size: 18.sp,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
            onPressed: onWishlistTap,
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
                constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
                onPressed: onBagTap,
              ),
              if (bagCount > 0)
                Positioned(
                  top: 6.h,
                  right: 6.w,
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
    );
  }
}
