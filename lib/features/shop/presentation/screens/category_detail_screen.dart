import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_cubit.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_state.dart';
import 'package:looks_loop/features/shop/presentation/widgets/category_detail_header.dart';
import 'package:looks_loop/features/shop/presentation/widgets/category_sub_nav_bar.dart';
import 'package:looks_loop/features/shop/presentation/widgets/category_subcat_list.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_editorial_card.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_product_rail.dart';

class CategoryDetailScreen extends StatelessWidget {
  final ShopAudienceEntity audience;

  const CategoryDetailScreen({super.key, required this.audience});

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
              Container(
                color: ColorManager.ink,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AnnouncementBar(),
                      CategorySubNavBar(title: audience.title),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<CategoryDetailCubit, CategoryDetailState>(
                  builder: (context, state) {
                    return switch (state) {
                      CategoryDetailInitial() || CategoryDetailLoading() =>
                        Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.olive,
                            strokeWidth: 2.w,
                          ),
                        ),
                      CategoryDetailError(:final message) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message,
                                style: TextStyles.font13TextBold(context)
                                    .copyWith(
                                  color: Colors.red,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Gap(12.h),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<CategoryDetailCubit>()
                                    .loadCategoryDetail(audience.id),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      CategoryDetailLoaded(:final data, :final wishlistedProductIds) =>
                        RefreshIndicator(
                          onRefresh: () => context
                              .read<CategoryDetailCubit>()
                              .loadCategoryDetail(audience.id),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CategoryDetailHeader(
                                  title: data.audienceTitle,
                                  totalCount: data.totalProductCount,
                                  onShopBreadcrumbTap: () =>
                                      Navigator.of(context).maybePop(),
                                ),
                                CategorySubcatList(
                                  subcategories: data.subcategories,
                                ),
                                Gap(20.h),
                                ShopEditorialCard(editorial: data.editorial),
                                ShopProductRail(
                                  products: data.railProducts,
                                  wishlistedIds: wishlistedProductIds,
                                  onWishlistToggle: (id) => context
                                      .read<CategoryDetailCubit>()
                                      .toggleWishlist(id),
                                ),
                                Gap(20.h),
                              ],
                            ),
                          ),
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
