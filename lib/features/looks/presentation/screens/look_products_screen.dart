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
        body: BlocBuilder<LookDetailCubit, LookDetailState>(
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
              LookDetailLoaded(:final look) => ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  itemCount: look.hotspots.length,
                  itemBuilder: (context, index) {
                    final item = look.hotspots[index].product;
                    return LookProductItemCard(
                      key: ValueKey(item.id),
                      product: item,
                      onViewProduct: () => _openProduct(context, item.slug, item.id),
                      onAddToBag: () => _openProduct(context, item.slug, item.id),
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
