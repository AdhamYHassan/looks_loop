import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BrandsSubNavBar extends StatelessWidget {
  final VoidCallback? onSearchTap;

  const BrandsSubNavBar({
    super.key,
    this.onSearchTap,
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
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Gap(4.w),
          Expanded(
            child: Text(
              'BRANDS',
              style: TextStyles.font13TextBold(context).copyWith(
                color: ColorManager.cream,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(
              LucideIcons.search,
              color: ColorManager.cream,
              size: 18.sp,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
            onPressed: onSearchTap,
          ),
          IconButton(
            icon: Icon(
              LucideIcons.shoppingBag,
              color: ColorManager.cream,
              size: 18.sp,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
            onPressed: () => context.push(Routes.cart),
          ),
        ],
      ),
    );
  }
}
