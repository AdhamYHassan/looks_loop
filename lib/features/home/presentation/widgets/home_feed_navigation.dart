import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_args.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:looks_loop/features/shop/presentation/models/category_detail_args.dart';

abstract final class HomeFeedNavigation {
  static void openCategory(BuildContext context, CategoryEntity cat, List<ProductEntity> newIn) {
    context.push(
      Routes.categoryDetail,
      extra: CategoryDetailArgs(
        id: cat.id,
        title: cat.name,
        slug: cat.slug,
        subcategories: cat.subcategories
            .map((sub) => SubCategoryEntity(
                  id: sub.id.toString(),
                  name: sub.name,
                  slug: sub.slug,
                  productCount: 0,
                  imageUrl: sub.imageUrl,
                ))
            .toList(),
        railProducts: newIn,
      ),
    );
  }

  static void openBrand(BuildContext context, HomeBrandEntity brand) {
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
  }

  static void openShopTheLook(BuildContext context, FeaturedLookEntity look) {
    context.push(Routes.lookProducts, extra: look);
  }

  static void openExploreLooks(BuildContext context) {
    context.push(Routes.looks);
  }

  static void openTrendingViewAll(BuildContext context) {
    context.push(
      Routes.productList,
      extra: const ProductListArgs(
        category: '',
        subcategory: '',
        categoryTitle: 'TRENDING',
        subcategoryTitle: 'NOW',
        isTrending: true,
      ),
    );
  }

  static void openSaleViewAll(BuildContext context) {
    context.push(
      Routes.productList,
      extra: const ProductListArgs(
        category: '',
        subcategory: '',
        categoryTitle: 'SPECIAL OFFERS',
        subcategoryTitle: 'ON SALE',
        isSale: true,
      ),
    );
  }

  static void openProduct(BuildContext context, ProductEntity product) {
    final slug = product.slug.isNotEmpty ? product.slug : product.id;
    if (slug.isNotEmpty) {
      context.push(Routes.productDetailPath(slug));
    }
  }
}
