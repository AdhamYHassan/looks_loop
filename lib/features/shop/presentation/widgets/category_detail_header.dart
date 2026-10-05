import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CategoryDetailHeader extends StatelessWidget {
  final String title;
  final int totalCount;
  final VoidCallback? onShopBreadcrumbTap;

  const CategoryDetailHeader({
    super.key,
    required this.title,
    required this.totalCount,
    this.onShopBreadcrumbTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BreadcrumbRow(
            currentTitle: title,
            onShopTap: onShopBreadcrumbTap,
          ),
          Gap(8.h),
          Text(
            title.toUpperCase(),
            style: TextStyles.font26TextBlack(context).copyWith(
              fontSize: 26.sp,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w900,
            ),
          ),
          Gap(4.h),
          Text(
            tr('shop.products_count', args: ['$totalCount']),
            style: TextStyles.font11Eyebrow(context).copyWith(
              fontSize: 11.sp,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _BreadcrumbRow extends StatelessWidget {
  final String currentTitle;
  final VoidCallback? onShopTap;

  const _BreadcrumbRow({
    required this.currentTitle,
    this.onShopTap,
  });

  @override
  Widget build(BuildContext context) {
    final mutedColor = ColorManager.getTextMuted(context);
    final activeColor = ColorManager.getText(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onShopTap,
          child: Text(
            tr('shop.shop_breadcrumb'),
            style: TextStyles.font11Eyebrow(context).copyWith(
              fontSize: 11.sp,
              color: mutedColor,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Gap(4.w),
        Icon(
          LucideIcons.chevronRight,
          size: 12.sp,
          color: mutedColor,
        ),
        Gap(4.w),
        Text(
          currentTitle.toUpperCase(),
          style: TextStyles.font11Eyebrow(context).copyWith(
            fontSize: 11.sp,
            color: activeColor,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
