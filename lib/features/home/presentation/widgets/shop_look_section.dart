import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ShopLookSection extends StatelessWidget {
  final CuratedLookEntity curatedLook;
  final VoidCallback? onShopTap;

  const ShopLookSection({
    super.key,
    required this.curatedLook,
    this.onShopTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Container(
        height: 400.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Colors.grey.shade200,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(
              imageUrl: curatedLook.imageUrl,
              fit: BoxFit.cover,
              memCacheWidth: 700,
              memCacheHeight: 600,
              maxDiskWidth: 800,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.3, 1.0],
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
                  Text(
                    curatedLook.eyebrow,
                    style: TextStyles.font11WhiteEyebrow,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    curatedLook.title,
                    style: TextStyles.font26CreamBlack.copyWith(
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    curatedLook.piecesLabel,
                    style: TextStyles.font11WhiteEyebrow.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton.icon(
                    onPressed: onShopTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    iconAlignment: IconAlignment.end,
                    icon: Icon(LucideIcons.arrowUpRight, size: 16.sp),
                    label: Text(
                      curatedLook.ctaText,
                      style: TextStyles.font11BlackCta,
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
