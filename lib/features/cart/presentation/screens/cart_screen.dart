import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/loaders/loaders.dart';
import 'package:looks_loop/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:looks_loop/features/cart/presentation/bloc/cart_state.dart';
import 'package:looks_loop/features/cart/presentation/widgets/cart_announcement_bar.dart';
import 'package:looks_loop/features/cart/presentation/widgets/cart_empty_view.dart';
import 'package:looks_loop/features/cart/presentation/widgets/cart_error_view.dart';
import 'package:looks_loop/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:looks_loop/features/cart/presentation/widgets/cart_sticky_cta.dart';
import 'package:looks_loop/features/cart/presentation/widgets/cart_sub_nav_bar.dart';
import 'package:looks_loop/features/cart/presentation/widgets/cart_summary_section.dart';
import 'package:looks_loop/features/cart/presentation/widgets/cart_voucher_section.dart';

class CartScreen extends StatelessWidget {
  final CartCubit? cubit;

  const CartScreen({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    if (cubit != null) {
      return BlocProvider.value(
        value: cubit!,
        child: const _CartScreenContent(),
      );
    }

    if (getIt.isRegistered<CartCubit>()) {
      return BlocProvider(
        create: (_) => getIt<CartCubit>()..getCart(),
        child: const _CartScreenContent(),
      );
    }

    return Scaffold(
      backgroundColor: ColorManager.getBackground(context),
      body: const SafeArea(child: CartEmptyView()),
    );
  }
}

class _CartScreenContent extends StatelessWidget {
  const _CartScreenContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final itemCount = state is CartLoaded ? state.cart.totalItemCount : 0;

        return Scaffold(
          backgroundColor: ColorManager.getBackground(context),
          bottomNavigationBar: state is CartLoaded
              ? CartStickyCta(
                  total: state.cart.summary.total,
                  onCheckout: () {},
                )
              : null,
          body: SafeArea(
            child: Column(
              children: [
                const CartAnnouncementBar(),
                CartSubNavBar(
                  itemCount: itemCount,
                  onBack: () => context.pop(),
                  onSearch: () {},
                ),
                Expanded(
                  child: switch (state) {
                    CartInitial() || CartLoading() => Center(
                        child: LookAroundEyesLoader(
                          width: 80.w,
                          color: ColorManager.olive,
                        ),
                      ),
                    CartEmpty() => const CartEmptyView(),
                    CartError(:final message) => CartErrorView(
                        message: message,
                        onRetry: () => context.read<CartCubit>().getCart(),
                      ),
                    CartLoaded() => _buildLoadedList(context, state),
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadedList(BuildContext context, CartLoaded state) {
    final cubit = context.read<CartCubit>();
    final cart = state.cart;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        ...cart.items.map(
          (item) => CartItemCard(
            item: item,
            onQuantityChanged: (qty) =>
                cubit.updateQuantity(itemId: item.id, quantity: qty),
            onRemove: () => cubit.removeItem(item.id),
          ),
        ),
        CartVoucherSection(
          appliedCode: cart.appliedPromoCode,
          onApplyPromo: (code) => cubit.applyPromoCode(code),
          onRemovePromo: () => cubit.removePromoCode(),
          errorMessage: state.promoError,
          isLoading: state.isApplyingPromo,
        ),
        CartSummarySection(summary: cart.summary),
        Gap(20.h),
      ],
    );
  }
}
