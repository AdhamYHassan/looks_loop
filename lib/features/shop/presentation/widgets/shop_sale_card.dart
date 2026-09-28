import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ShopSaleCard extends StatelessWidget {
  final ShopSaleBannerEntity banner;
  final VoidCallback? onCtaTap;

  const ShopSaleCard({super.key, required this.banner, this.onCtaTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: ColorManager.orange.withValues(alpha: 0.35),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(banner.eyebrow, style: TextStyles.font10WhiteMedium),
            Gap(6.h),
            Text(banner.title, style: TextStyles.font26CreamBlack),
            Gap(4.h),
            Text(banner.subTitle, style: TextStyles.font11SageSemiBold),
            Gap(20.h),
            ElevatedButton.icon(
              onPressed: onCtaTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.orange,
                disabledBackgroundColor: ColorManager.orange,
                foregroundColor: ColorManager.white,
                disabledForegroundColor: ColorManager.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              iconAlignment: IconAlignment.end,
              icon: Icon(LucideIcons.arrowUpRight, size: 16.sp),
              label: Text(
                banner.ctaText,
                style: TextStyles.font11BlackCta.copyWith(
                  color: ColorManager.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
