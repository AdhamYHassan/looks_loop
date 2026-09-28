import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/product_card.dart';
import 'package:looks_loop/features/home/presentation/widgets/section_header.dart';

class ProductRailSection extends StatelessWidget {
  final List<ProductEntity> products;
  final Set<String> wishlistedIds;
  final ValueChanged<String>? onWishlistToggle;
  final ValueChanged<ProductEntity>? onProductTap;
  final VoidCallback? onViewAllTap;

  const ProductRailSection({
    super.key,
    required this.products,
    this.wishlistedIds = const {},
    this.onWishlistToggle,
    this.onProductTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: '02 / THE LATEST',
          title: 'NEW IN',
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
