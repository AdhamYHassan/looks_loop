import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_args.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/presentation/models/shop_feed_resolvers.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_brand_strip.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_cat_selector.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_category_grid.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_editorial_card.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_hub_header.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_product_rail.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_quick_links.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_sale_card.dart';

class ShopFeedContent extends StatelessWidget {
  final ShopFeedData feedData;
  final HomeFeedData? homeFeedData;
  final String selectedAudienceId;
  final String selectedQuickLink;
  final Set<String> wishlistedIds;
  final ValueChanged<ShopAudienceEntity>? onSelectAudience;
  final ValueChanged<ShopCategoryEntity>? onCategoryTap;
  final VoidCallback? onViewAllCategories;
  final ValueChanged<String>? onSelectQuickLink;
  final ValueChanged<String>? onWishlistToggle;
  final ValueChanged<ProductEntity>? onProductTap;
  final Future<void> Function()? onRefresh;

  const ShopFeedContent({
    super.key,
    required this.feedData,
    this.homeFeedData,
    required this.selectedAudienceId,
    required this.selectedQuickLink,
    this.wishlistedIds = const {},
    this.onSelectAudience,
    this.onCategoryTap,
    this.onViewAllCategories,
    this.onSelectQuickLink,
    this.onWishlistToggle,
    this.onProductTap,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final audiences = ShopFeedResolvers.resolveAudiences(
      homeFeedData: homeFeedData,
      fallback: feedData.audiences,
    );
    final selectedCat = ShopFeedResolvers.resolveSelectedCategory(
      homeFeedData: homeFeedData,
      selectedAudienceId: selectedAudienceId,
    );
    final subcategories = ShopFeedResolvers.resolveSubcategories(
      selectedCat: selectedCat,
      fallback: feedData.categories,
    );
    final audienceTitle =
        selectedCat?.name.toUpperCase() ?? _resolveAudienceTitle();
    final newIn =
        (homeFeedData != null && homeFeedData!.newInProducts.isNotEmpty)
            ? homeFeedData!.newInProducts
            : feedData.newInProducts;

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RepaintBoundary(child: ShopHubHeader()),
            RepaintBoundary(
              child: ShopCatSelector(
                audiences: audiences,
                onSelectAudience: onSelectAudience,
              ),
            ),
            RepaintBoundary(
              child: ShopQuickLinks(
                links: feedData.quickLinks,
                selectedLink: selectedQuickLink,
                onLinkSelected: onSelectQuickLink,
              ),
            ),
            RepaintBoundary(
              child: ShopCategoryGrid(
                categories: subcategories,
                audienceTitle: audienceTitle,
                onCategoryTap: onCategoryTap,
                onViewAllTap: onViewAllCategories,
              ),
            ),
            RepaintBoundary(
              child: ShopEditorialCard(editorial: feedData.editorial),
            ),
            RepaintBoundary(
              child: ShopProductRail(
                products: newIn,
                wishlistedIds: wishlistedIds,
                onWishlistToggle: onWishlistToggle,
                onProductTap: onProductTap,
              ),
            ),
            RepaintBoundary(child: ShopSaleCard(banner: feedData.saleBanner)),
            RepaintBoundary(
              child: ShopBrandStrip(
                brands: feedData.brands,
                onViewAllTap: () => context.push(Routes.brands),
                onBrandTap: (brand) {
                  final slug = brand.slug.isNotEmpty
                      ? brand.slug
                      : brand.name.toLowerCase().trim().replaceAll(' ', '-');
                  context.push(
                    Routes.productList,
                    extra: ProductListArgs(
                      category: '',
                      subcategory: '',
                      categoryTitle: 'BRANDS',
                      subcategoryTitle: brand.name,
                      initialBrands: [slug],
                      isBrandFilterLocked: true,
                    ),
                  );
                },
              ),
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }

  String _resolveAudienceTitle() {
    for (final audience in feedData.audiences) {
      if (audience.id == selectedAudienceId) return audience.title;
    }
    return feedData.audiences.isNotEmpty
        ? feedData.audiences.first.title
        : 'Women';
  }
}
