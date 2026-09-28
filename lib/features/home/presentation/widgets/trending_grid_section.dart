import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/section_header.dart';

class TrendingGridSection extends StatelessWidget {
  final List<TrendingItemEntity> items;
  final ValueChanged<TrendingItemEntity>? onItemTap;
  final VoidCallback? onViewAllTap;

  const TrendingGridSection({
    super.key,
    required this.items,
    this.onItemTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: '03 / IN THE LOOP',
          title: 'TRENDING NOW',
          onActionTap: onViewAllTap,
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return _TrendingCard(
                item: item,
                onTap: () => onItemTap?.call(item),
              );
            },
          ),
        ),
        SizedBox(height: 28.h),
      ],
    );
  }
}

class _TrendingCard extends StatelessWidget {
  final TrendingItemEntity item;
  final VoidCallback? onTap;

  const _TrendingCard({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(
              imageUrl: item.imageUrl,
              fit: BoxFit.cover,
              memCacheWidth: 450,
              memCacheHeight: 600,
              maxDiskWidth: 700,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 10.w,
              right: 10.w,
              bottom: 10.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.brand,
                    style: TextStyles.font10WhiteMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font13WhiteBlack.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${item.price.toInt()} EGP',
                    style: TextStyles.font13WhiteBlack.copyWith(fontSize: 11.sp),
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
