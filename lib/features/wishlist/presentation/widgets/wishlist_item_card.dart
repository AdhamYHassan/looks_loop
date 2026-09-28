import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class WishlistItemCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const WishlistItemCard({
    super.key,
    required this.product,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceColor = ColorManager.getSurface(context);
    final borderColor = ColorManager.getBorder(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderColor, width: 0.5.w),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: 80.w,
                height: 102.h,
                child: AppCachedImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.fill,
                  memCacheWidth: 240,
                  memCacheHeight: 310,
                ),
              ),
            ),
            Gap(14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font11Eyebrow(
                      context,
                    ).copyWith(letterSpacing: 0.8, fontWeight: FontWeight.w600),
                  ),
                  Gap(4.h),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font13TextBold(context),
                  ),
                  Gap(6.h),
                  _buildPriceRow(context),
                ],
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Icon(
                  LucideIcons.heart,
                  color: ColorManager.orange,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context) {
    final hasDiscount =
        product.originalPrice != null && product.originalPrice! > product.price;

    return Row(
      children: [
        Text(
          '${product.price.toInt()} EGP',
          style: TextStyles.font12Price(context, isDiscounted: hasDiscount),
        ),
        if (hasDiscount) ...[
          Gap(6.w),
          Text(
            '${product.originalPrice!.toInt()} EGP',
            style: TextStyles.font11MutedLineThrough(context),
          ),
        ],
      ],
    );
  }
}
