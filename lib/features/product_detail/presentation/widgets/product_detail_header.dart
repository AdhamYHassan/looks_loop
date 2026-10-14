import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/product_detail/presentation/bloc/product_detail_cubit.dart';
import 'package:looks_loop/features/product_detail/presentation/bloc/product_detail_state.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_detail_sub_nav_bar.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';

class ProductDetailHeader extends StatelessWidget {
  const ProductDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.ink,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AnnouncementBar(
              text: 'NEW DROPS EVERY FRIDAY — 8 PM',
            ),
            BlocBuilder<ProductDetailCubit, ProductDetailState>(
              buildWhen: (prev, curr) {
                if (prev is ProductDetailLoaded && curr is ProductDetailLoaded) {
                  return prev.bagCount != curr.bagCount ||
                      prev.product.id != curr.product.id;
                }
                return true;
              },
              builder: (context, state) {
                final bagCount =
                    state is ProductDetailLoaded ? state.bagCount : 0;
                final product =
                    state is ProductDetailLoaded ? state.product : null;

                return BlocSelector<WishlistCubit, WishlistState, bool>(
                  selector: (wState) {
                    if (product == null) return false;
                    if (wState is WishlistLoaded) {
                      return wState.items.any((item) =>
                          item.id.trim() == product.id.toString().trim());
                    }
                    return product.isWishlisted;
                  },
                  builder: (context, isWishlisted) {
                    return ProductDetailSubNavBar(
                      isWishlisted: isWishlisted,
                      bagCount: bagCount,
                      onBackTap: () => context.pop(),
                      onWishlistTap: () {
                        if (product != null) {
                          context
                              .read<WishlistCubit>()
                              .toggleItem(product.toProductEntity());
                        }
                      },
                      onBagTap: () => context.push(Routes.cart),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
