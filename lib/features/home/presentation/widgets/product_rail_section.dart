import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/product_card.dart';
import 'package:looks_loop/features/home/presentation/widgets/section_header.dart';

import 'package:easy_localization/easy_localization.dart';

class ProductRailSection extends StatelessWidget {
  final String? eyebrow;
  final String? title;
  final List<ProductEntity> products;
  final Set<String> wishlistedIds;
  final ValueChanged<String>? onWishlistToggle;
  final ValueChanged<ProductEntity>? onProductTap;
  final VoidCallback? onViewAllTap;

  const ProductRailSection({
    super.key,
    this.eyebrow,
    this.title,
    required this.products,
    this.wishlistedIds = const {},
    this.onWishlistToggle,
    this.onProductTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    final effectiveEyebrow = eyebrow ?? 'home.the_latest_eyebrow'.tr();
    final effectiveTitle = title ?? 'home.new_in'.tr();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: effectiveEyebrow,
          title: effectiveTitle,
          onActionTap: onViewAllTap,
        ),
        SizedBox(height: 4.h),
        SizedBox(
          height: 275.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, _) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final product = products[index];
              final isWishlisted = wishlistedIds.contains(product.id);
              return ProductCard(
                product: product,
                isWishlisted: isWishlisted,
                onWishlistTap: () => onWishlistToggle?.call(product.id),
                onTap: () => onProductTap?.call(product),
              );
            },
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
