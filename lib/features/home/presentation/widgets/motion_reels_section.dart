import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/section_header.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MotionReelsSection extends StatelessWidget {
  final List<MotionReelEntity> reels;
  final ValueChanged<MotionReelEntity>? onReelTap;
  final VoidCallback? onExploreTap;

  const MotionReelsSection({
    super.key,
    required this.reels,
    this.onReelTap,
    this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    if (reels.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 28.h),
        SectionHeader(
          eyebrow: '05 / LOOK LOOPS',
          title: 'SEE IT IN MOTION',
          actionLabel: 'EXPLORE',
          onActionTap: onExploreTap,
        ),
        SizedBox(height: 4.h),
        SizedBox(
          height: 240.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            scrollDirection: Axis.horizontal,
            itemCount: reels.length,
            separatorBuilder: (_, _) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final reel = reels[index];
              return _ReelCard(reel: reel, onTap: () => onReelTap?.call(reel));
            },
          ),
        ),
        SizedBox(height: 28.h),
      ],
    );
  }
}

class _ReelCard extends StatelessWidget {
  final MotionReelEntity reel;
  final VoidCallback? onTap;

  const _ReelCard({required this.reel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        height: 240.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Colors.grey.shade200,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(
              imageUrl: reel.thumbnailUrl,
              fit: BoxFit.cover,
              memCacheWidth: 450,
              memCacheHeight: 700,
              maxDiskWidth: 700,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.play, color: Colors.black, size: 18.sp),
              ),
            ),
            Positioned(
              left: 10.w,
              right: 10.w,
              bottom: 12.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    reel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font13WhiteBlack.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    reel.views,
                    style: TextStyles.font10WhiteMedium,
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
