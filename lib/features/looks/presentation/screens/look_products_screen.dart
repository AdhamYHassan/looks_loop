import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/domain/entities/featured_look_entity.dart';
import 'package:looks_loop/features/looks/presentation/bloc/look_detail_cubit.dart';
import 'package:looks_loop/features/looks/presentation/bloc/look_detail_state.dart';
import 'package:looks_loop/features/looks/presentation/widgets/look_product_item_card.dart';
import 'package:looks_loop/features/looks/presentation/widgets/look_products_app_bar.dart';

class LookProductsScreen extends StatefulWidget {
  final FeaturedLookEntity? initialLook;
  final String slug;

  const LookProductsScreen({
    super.key,
    this.initialLook,
    this.slug = '',
  });

  @override
  State<LookProductsScreen> createState() => _LookProductsScreenState();
}

class _LookProductsScreenState extends State<LookProductsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.initialLook != null) {
      context.read<LookDetailCubit>().initWithLook(widget.initialLook!);
    } else if (widget.slug.isNotEmpty) {
      context.read<LookDetailCubit>().fetchLookDetail(widget.slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.getBackground(context),
        appBar: LookProductsAppBar(
          initialCount: widget.initialLook?.hotspots.length ?? 0,
        ),
        body: BlocConsumer<LookDetailCubit, LookDetailState>(
          listener: (context, state) {
            if (state is LookDetailLoaded && state.bagActionMessage != null) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.bagActionMessage!,
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                  ),
                  backgroundColor: ColorManager.ink,
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.read<LookDetailCubit>().clearBagActionMessage();
            }
          },
          builder: (context, state) {
            return switch (state) {
              LookDetailInitial() || LookDetailLoading() => Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.olive,
                    strokeWidth: 2.w,
                  ),
                ),
              LookDetailError(:final message) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message,
                        style: TextStyle(color: Colors.red, fontSize: 13.sp),
                      ),
                      Gap(12.h),
                      ElevatedButton(
                        onPressed: () => context
                            .read<LookDetailCubit>()
                            .fetchLookDetail(widget.slug),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              LookDetailLoaded(:final look, :final addingProductId) =>
                ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  itemCount: look.hotspots.length,
                  itemBuilder: (context, index) {
                    final item = look.hotspots[index].product;
                    return LookProductItemCard(
                      key: ValueKey(item.id),
                      product: item,
                      isAddingToBag: addingProductId == item.id,
                      onViewProduct: () =>
                          _openProduct(context, item.slug, item.id),
                      onAddToBag: ({colorId, size}) {
                        context.read<LookDetailCubit>().addProductToBag(
                              product: item,
                              colorId: colorId,
                              size: size,
                            );
                      },
                    );
                  },
                ),
            };
          },
        ),
      ),
    );
  }

  void _openProduct(BuildContext context, String slug, String id) {
    final effectiveSlug = slug.isNotEmpty ? slug : id;
    if (effectiveSlug.isNotEmpty) {
      context.push(Routes.productDetailPath(effectiveSlug));
    }
  }
}
