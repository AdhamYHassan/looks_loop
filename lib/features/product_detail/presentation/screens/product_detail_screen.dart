import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/product_detail/presentation/bloc/product_detail_cubit.dart';
import 'package:looks_loop/features/product_detail/presentation/bloc/product_detail_state.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_detail_body.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_detail_header.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_sticky_cta.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.getBackground(context),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              const ProductDetailHeader(),
              Expanded(
                child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
                  builder: (context, state) {
                    return switch (state) {
                      ProductDetailInitial() || ProductDetailLoading() =>
                        Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.olive,
                            strokeWidth: 2.w,
                          ),
                        ),
                      ProductDetailError(:final message) =>
                        _buildErrorState(context, message),
                      ProductDetailLoaded() => ProductDetailBody(state: state),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            BlocConsumer<ProductDetailCubit, ProductDetailState>(
          listenWhen: (prev, curr) =>
              curr is ProductDetailLoaded &&
              prev is ProductDetailLoaded &&
              curr.bagActionMessage != prev.bagActionMessage &&
              curr.bagActionMessage != null,
          listener: (context, state) {
            if (state is ProductDetailLoaded && state.bagActionMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.bagActionMessage!),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'VIEW BAG',
                    textColor: ColorManager.cream,
                    onPressed: () => context.push(Routes.cart),
                  ),
                ),
              );
            }
          },
          buildWhen: (prev, curr) => curr is ProductDetailLoaded,
          builder: (context, state) {
            if (state is ProductDetailLoaded) {
              return ProductStickyCta(
                price: state.product.price,
                currency: 'EGP',
                isAvailable: state.isSelectedVariantAvailable,
                isLoading: state.isAddingToBag,
                onAddToBag: () => context.read<ProductDetailCubit>().addToBag(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: TextStyles.font13TextBold(context)
                .copyWith(color: Colors.red),
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () =>
                context.read<ProductDetailCubit>().loadProductDetail(productId),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
