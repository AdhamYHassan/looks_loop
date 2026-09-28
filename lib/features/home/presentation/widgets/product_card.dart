import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final bool isWishlisted;
  final VoidCallback? onWishlistTap;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.isWishlisted = false,
    this.onWishlistTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 156.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200.h,
                  width: 156.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: ColorManager.getSurface(context),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AppCachedImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.cover,
                    memCacheWidth: 400,
                    memCacheHeight: 500,
                    maxDiskWidth: 600,
                  ),
                ),
                Positioned(top: 8.h, right: 8.w, child: _buildWishlistButton()),
                if (product.discountPercent != null)
                  Positioned(bottom: 8.h, left: 8.w, child: _buildDiscountBadge()),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              product.brand,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.font11Eyebrow(context).copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.font13TextBold(context),
            ),
            SizedBox(height: 4.h),
            _buildPriceRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistButton() {
    return GestureDetector(
      onTap: onWishlistTap,
      child: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          LucideIcons.heart,
          size: 16.sp,
          color: isWishlisted ? const Color(0xFFE53935) : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: ColorManager.ink,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Text(
        '-${product.discountPercent}%',
        style: TextStyles.font10DiscountBadge,
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context) {
    return Row(
      children: [
        Text(
          '${product.price.toInt()} EGP',
          style: TextStyles.font12Price(
            context,
            isDiscounted: product.discountPercent != null,
          ),
        ),
        if (product.originalPrice != null) ...[
          SizedBox(width: 6.w),
          Text(
            '${product.originalPrice!.toInt()} EGP',
            style: TextStyles.font11MutedLineThrough(context),
          ),
        ],
      ],
    );
  }
}
