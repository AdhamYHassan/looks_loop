import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ShopEditorialCard extends StatelessWidget {
  final ShopEditorialEntity editorial;
  final VoidCallback? onCtaTap;

  const ShopEditorialCard({super.key, required this.editorial, this.onCtaTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Container(
        height: 270.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Colors.grey.shade300,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(
              imageUrl: editorial.imageUrl,
              fit: BoxFit.cover,
              memCacheWidth: 1000,
              memCacheHeight: 900,
              maxDiskWidth: 1200,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.35, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 24.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(editorial.eyebrow, style: TextStyles.font11WhiteEyebrow),
                  Gap(6.h),
                  Text(
                    '${editorial.titleLine1}\n${editorial.titleLine2}',
                    style: TextStyles.font28WhiteBlack,
                  ),
                  Gap(16.h),
                  GestureDetector(
                    onTap: onCtaTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 9.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            editorial.ctaText,
                            style: TextStyles.font11BlackCta,
                          ),
                          Gap(6.w),
                          Icon(
                            LucideIcons.arrowUpRight,
                            size: 15.sp,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
