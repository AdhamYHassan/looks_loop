import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HeroSlideItem extends StatelessWidget {
  final HeroSlideEntity slide;
  final VoidCallback? onCtaTap;

  const HeroSlideItem({
    super.key,
    required this.slide,
    this.onCtaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppCachedImage(
          imageUrl: slide.imageUrl,
          fit: BoxFit.cover,
          memCacheWidth: 1080,
          maxDiskWidth: 1200,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.85),
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
        Positioned(
          left: 20.w,
          right: 20.w,
          bottom: 44.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                slide.eyebrow,
                style: TextStyles.font11WhiteEyebrow,
              ),
              SizedBox(height: 6.h),
              Text(
                slide.title,
                style: TextStyles.font32WhiteBlack,
              ),
              SizedBox(height: 10.h),
              Text(
                slide.copy,
                style: TextStyles.font13White70Regular,
              ),
              SizedBox(height: 16.h),
              ElevatedButton.icon(
                onPressed: onCtaTap,
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
                  slide.ctaText,
                  style: TextStyles.font11BlackCta.copyWith(letterSpacing: 1.2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
