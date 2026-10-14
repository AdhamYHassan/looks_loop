import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_args.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/presentation/models/category_detail_args.dart';

class ShopFeedResolvers {
  ShopFeedResolvers._();

  static List<ShopAudienceEntity> resolveAudiences({
    required HomeFeedData? homeFeedData,
    required List<ShopAudienceEntity> fallback,
  }) {
    final categories = homeFeedData?.categories ?? const [];
    if (categories.isEmpty) return fallback;
    return categories.asMap().entries.map((entry) {
      final cat = entry.value;
      final slug = cat.slug.isNotEmpty ? cat.slug : cat.name.toLowerCase().trim();
      return ShopAudienceEntity(
        id: cat.id, title: cat.name.toUpperCase(), slug: slug, imageUrl: cat.imageUrl, isLarge: entry.key == 0);
    }).toList();
  }

  static CategoryEntity? resolveSelectedCategory({
    required HomeFeedData? homeFeedData,
    required String selectedAudienceId,
  }) {
    final categories = homeFeedData?.categories ?? const [];
    if (categories.isEmpty) return null;
    final audienceSlug = selectedAudienceId.toLowerCase();
    final audienceNormalized = selectedAudienceId.replaceAll('aud_', '').toLowerCase();
    return categories
            .where((c) =>
                c.id == selectedAudienceId ||
                c.slug.toLowerCase() == audienceSlug ||
                c.name.toLowerCase() == audienceNormalized)
            .firstOrNull ??
        categories.firstOrNull;
  }

  static List<ShopCategoryEntity> resolveSubcategories({
    required CategoryEntity? selectedCat,
    required List<ShopCategoryEntity> fallback,
  }) {
    if (selectedCat != null && selectedCat.subcategories.isNotEmpty) {
      return selectedCat.subcategories.take(4).map((sub) {
        final slug = sub.slug.isNotEmpty ? sub.slug : sub.name.toLowerCase().trim();
        return ShopCategoryEntity(
          id: sub.id.toString(), name: sub.name.toUpperCase(), slug: slug, productCount: 0, imageUrl: sub.imageUrl);
      }).toList();
    }
    return fallback.take(4).toList();
  }

  static void navigateToSubcategory(
    BuildContext context, {
    required HomeFeedData? homeData,
    required String selectedAudienceId,
    required ShopCategoryEntity subcat,
  }) {
    final cat = resolveSelectedCategory(
      homeFeedData: homeData,
      selectedAudienceId: selectedAudienceId,
    );
    final catSlug = ProductListArgs.resolveSlug(cat?.slug ?? '', cat?.name ?? 'Women');
    final subSlug = ProductListArgs.resolveSlug(subcat.slug, subcat.name);
    context.push(
      Routes.productList,
      extra: ProductListArgs(
        category: catSlug,
        subcategory: subSlug,
        categoryTitle: cat?.name ?? 'Women',
        subcategoryTitle: subcat.name,
      ),
    );
  }

  static void navigateToCategory(
    BuildContext context, {
    required HomeFeedData? homeData,
    required String categoryId,
    required List<ProductEntity> fallbackRail,
    String? fallbackTitle,
    String? fallbackSlug,
  }) {
    final cat = resolveSelectedCategory(
      homeFeedData: homeData,
      selectedAudienceId: categoryId,
    );
    final subs = cat?.subcategories
            .map((s) => SubCategoryEntity(
                  id: s.id.toString(), name: s.name, slug: s.slug, productCount: 0, imageUrl: s.imageUrl))
            .toList() ??
        const [];
    context.push(
      Routes.categoryDetail,
      extra: CategoryDetailArgs(
        id: cat?.id ?? categoryId,
        title: cat?.name ?? fallbackTitle ?? 'Category',
        slug: cat?.slug ?? fallbackSlug ?? '',
        subcategories: subs,
        railProducts: homeData?.newInProducts ?? fallbackRail,
      ),
    );
  }

  static void navigateToAudience(
    BuildContext context, {
    required HomeFeedData? homeData,
    required ShopAudienceEntity audience,
    required List<ProductEntity> fallbackRail,
  }) {
    navigateToCategory(
      context,
      homeData: homeData,
      categoryId: audience.id,
      fallbackRail: fallbackRail,
      fallbackTitle: audience.title,
      fallbackSlug: audience.slug,
    );
  }

  static void navigateToViewAll(
    BuildContext context, {
    required HomeFeedData? homeData,
    required String selectedAudienceId,
    required List<ProductEntity> fallbackRail,
  }) {
    navigateToCategory(
      context,
      homeData: homeData,
      categoryId: selectedAudienceId,
      fallbackRail: fallbackRail,
    );
  }
}
