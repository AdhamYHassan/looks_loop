import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
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
  final String selectedAudienceId;
  final String selectedQuickLink;
  final Set<String> wishlistedIds;
  final ValueChanged<ShopAudienceEntity>? onSelectAudience;
  final ValueChanged<String>? onSelectQuickLink;
  final ValueChanged<String>? onWishlistToggle;
  final ValueChanged<ProductEntity>? onProductTap;
  final Future<void> Function()? onRefresh;

  const ShopFeedContent({
    super.key,
    required this.feedData,
    required this.selectedAudienceId,
    required this.selectedQuickLink,
    this.wishlistedIds = const {},
    this.onSelectAudience,
    this.onSelectQuickLink,
    this.onWishlistToggle,
    this.onProductTap,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
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
                audiences: feedData.audiences,
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
                categories: feedData.categories,
                audienceTitle: _resolveAudienceTitle(),
              ),
            ),
            RepaintBoundary(child: ShopEditorialCard(editorial: feedData.editorial)),
            RepaintBoundary(
              child: ShopProductRail(
                products: feedData.newInProducts,
                wishlistedIds: wishlistedIds,
                onWishlistToggle: onWishlistToggle,
                onProductTap: onProductTap,
              ),
            ),
            RepaintBoundary(child: ShopSaleCard(banner: feedData.saleBanner)),
            RepaintBoundary(child: ShopBrandStrip(brands: feedData.brands)),
            Gap(20.h),
          ],
        ),
      ),
    );
  }

  String _resolveAudienceTitle() {
    for (final audience in feedData.audiences) {
      if (audience.id == selectedAudienceId) {
        return audience.title;
      }
    }
    return feedData.audiences.isNotEmpty ? feedData.audiences.first.title : 'Women';
  }
}
