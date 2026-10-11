import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/brand_strip_section.dart';
import 'package:looks_loop/features/home/presentation/widgets/categories_section.dart';
import 'package:looks_loop/features/home/presentation/widgets/editorial_section.dart';
import 'package:looks_loop/features/home/presentation/widgets/hero_carousel_section.dart';
import 'package:looks_loop/features/home/presentation/widgets/motion_reels_section.dart';
import 'package:looks_loop/features/home/presentation/widgets/product_rail_section.dart';
import 'package:looks_loop/features/home/presentation/widgets/shop_look_section.dart';
import 'package:looks_loop/features/home/presentation/widgets/trending_grid_section.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:looks_loop/features/shop/presentation/models/category_detail_args.dart';

class HomeFeedView extends StatelessWidget {
  final HomeFeedData feedData;
  final Set<String> wishlistedIds;
  final ValueChanged<String>? onWishlistToggle;
  final Future<void> Function()? onRefresh;

  const HomeFeedView({
    super.key,
    required this.feedData,
    this.wishlistedIds = const {},
    this.onWishlistToggle,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorManager.olive,
      onRefresh: onRefresh ?? () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepaintBoundary(
              child: HeroCarouselSection(slides: feedData.heroSlides),
            ),
            SizedBox(height: 24.h),
            RepaintBoundary(
              child: CategoriesSection(
                categories: feedData.categories,
                onCategoryTap: (cat) {
                  context.push(
                    Routes.categoryDetail,
                    extra: CategoryDetailArgs(
                      id: cat.id,
                      title: cat.name,
                      subcategories: cat.subcategories
                          .map((sub) => SubCategoryEntity(
                                id: sub.id.toString(),
                                name: sub.name,
                                productCount: 0,
                                imageUrl: sub.imageUrl,
                              ))
                          .toList(),
                      railProducts: feedData.newInProducts,
                    ),
                  );
                },
              ),
            ),
            RepaintBoundary(
              child: ProductRailSection(
                products: feedData.newInProducts,
                wishlistedIds: wishlistedIds,
                onWishlistToggle: onWishlistToggle,
              ),
            ),
            RepaintBoundary(
              child: TrendingGridSection(items: feedData.trendingProducts),
            ),
            if (feedData.featuredLook != null)
              RepaintBoundary(
                child: ShopLookSection(featuredLook: feedData.featuredLook!),
              ),
            if (feedData.featuredLoops.isNotEmpty)
              RepaintBoundary(
                child: MotionReelsSection(reels: feedData.featuredLoops),
              ),
            if (feedData.saleProducts.isNotEmpty)
              RepaintBoundary(
                child: ProductRailSection(
                  eyebrow: 'home.special_offers'.tr(),
                  title: 'home.on_sale'.tr(),
                  products: feedData.saleProducts,
                  wishlistedIds: wishlistedIds,
                  onWishlistToggle: onWishlistToggle,
                ),
              ),
            if (feedData.editorial != null)
              RepaintBoundary(
                child: EditorialSection(editorial: feedData.editorial!),
              ),
            RepaintBoundary(child: BrandStripSection(brands: feedData.brands)),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
