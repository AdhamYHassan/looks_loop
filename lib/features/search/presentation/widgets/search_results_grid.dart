import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/product_card.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';

class SearchResultsGrid extends StatelessWidget {
  final List<ProductEntity> products;

  const SearchResultsGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.58,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return RepaintBoundary(
          child: BlocSelector<WishlistCubit, WishlistState, bool>(
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
                onTap: () {
                  final slug = product.slug.isNotEmpty ? product.slug : product.id;
                  context.push(Routes.productDetailPath(slug));
                },
              );
            },
          ),
        );
      },
    );
  }
}
