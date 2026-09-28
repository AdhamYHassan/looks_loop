import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/presentation/widgets/section_header.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';

class ShopCategoryGrid extends StatelessWidget {
  final List<ShopCategoryEntity> categories;
  final String audienceTitle;
  final ValueChanged<ShopCategoryEntity>? onCategoryTap;
  final VoidCallback? onViewAllTap;

  const ShopCategoryGrid({
    super.key,
    required this.categories,
    this.audienceTitle = 'Women',
    this.onCategoryTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: 'SHOP BY CATEGORY',
          title: audienceTitle,
          actionLabel: 'VIEW ALL',
          onActionTap: onViewAllTap,
        ),
        Gap(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return _CategoryGridTile(
                category: cat,
                onTap: () => onCategoryTap?.call(cat),
              );
            },
          ),
        ),
        Gap(24.h),
      ],
    );
  }
}

class _CategoryGridTile extends StatelessWidget {
  final ShopCategoryEntity category;
  final VoidCallback? onTap;

  const _CategoryGridTile({required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Colors.grey.shade300,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(
              imageUrl: category.imageUrl,
              fit: BoxFit.fill,
              memCacheWidth: 400,
              memCacheHeight: 400,
              maxDiskWidth: 600,
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
                  Text(category.name, style: TextStyles.font13WhiteBlack),
                  Gap(2.h),
                  Text(
                    '${category.productCount} products',
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
