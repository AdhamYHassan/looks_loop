import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/product_card.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';

class ProductRecommendedRail extends StatelessWidget {
  final List<ProductEntity> products;
  final ValueChanged<ProductEntity>? onProductTap;

  const ProductRecommendedRail({
    super.key,
    required this.products,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'YOU MAY ALSO LIKE',
                style: TextStyles.font11Eyebrow(context).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'RECOMMENDED',
                style: TextStyles.font20Bold(context).copyWith(
                  fontSize: 22.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 290.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (_, _) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final product = products[index];
              return _RecommendedItemCard(
                product: product,
                onProductTap: onProductTap,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecommendedItemCard extends StatelessWidget {
  final ProductEntity product;
  final ValueChanged<ProductEntity>? onProductTap;

  const _RecommendedItemCard({
    required this.product,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WishlistCubit, WishlistState, bool>(
      selector: (state) {
        if (state is WishlistLoaded) {
          return state.items.any((item) => item.id.trim() == product.id.trim());
        }
        return product.isWishlisted;
      },
      builder: (context, isWishlisted) {
        return ProductCard(
          product: product,
          isWishlisted: isWishlisted,
          onWishlistTap: () =>
              context.read<WishlistCubit>().toggleItem(product),
          onTap: () => onProductTap?.call(product),
        );
      },
    );
  }
}
