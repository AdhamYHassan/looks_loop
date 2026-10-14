import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/product_card.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';

class ProductListGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final bool isLoadingMore;
  final ValueChanged<ProductEntity>? onProductTap;

  const ProductListGrid({
    super.key,
    required this.products,
    this.isLoadingMore = false,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60.h),
          child: Center(
            child: Text(
              'No products found matching your filters.',
              style: TextStyle(
                color: ColorManager.getTextMuted(context),
                fontSize: 13.sp,
              ),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 20.h,
          childAspectRatio: 0.58,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];
            return _ProductGridItem(
              product: product,
              onTap: () => onProductTap?.call(product),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}

class _ProductGridItem extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const _ProductGridItem({required this.product, this.onTap});

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
          onTap: onTap,
        );
      },
    );
  }
}
