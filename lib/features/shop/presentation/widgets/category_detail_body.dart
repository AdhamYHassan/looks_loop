import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_args.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_cubit.dart';
import 'package:looks_loop/features/shop/presentation/widgets/category_detail_header.dart';
import 'package:looks_loop/features/shop/presentation/widgets/category_subcat_list.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_editorial_card.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_product_rail.dart';

class CategoryDetailBody extends StatelessWidget {
  final CategoryDetailEntity data;
  final Set<String> wishlistedProductIds;
  final String title;
  final String id;
  final String slug;

  const CategoryDetailBody({
    super.key,
    required this.data,
    required this.wishlistedProductIds,
    required this.title,
    required this.id,
    this.slug = '',
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<CategoryDetailCubit>().loadCategoryDetail(id),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryDetailHeader(
              title: title,
              totalCount: data.totalProductCount,
              onShopBreadcrumbTap: () => Navigator.of(context).maybePop(),
            ),
            CategorySubcatList(
              subcategories: data.subcategories,
              onSubcatTap: (subcat) {
                final catSlug = ProductListArgs.resolveSlug(
                  slug.isNotEmpty ? slug : id,
                  title,
                );
                final subSlug = ProductListArgs.resolveSlug(
                  subcat.slug.isNotEmpty ? subcat.slug : subcat.id,
                  subcat.name,
                );
                context.push(
                  Routes.productList,
                  extra: ProductListArgs(
                    category: catSlug,
                    subcategory: subSlug,
                    categoryTitle: title,
                    subcategoryTitle: subcat.name,
                  ),
                );
              },
            ),
            if (data.editorial.imageUrl.isNotEmpty) ...[
              Gap(20.h),
              ShopEditorialCard(editorial: data.editorial),
            ],
            if (data.railProducts.isNotEmpty) ...[
              Gap(20.h),
              ShopProductRail(
                products: data.railProducts,
                wishlistedIds: wishlistedProductIds,
                onWishlistToggle: (prodId) =>
                    context.read<CategoryDetailCubit>().toggleWishlist(prodId),
              ),
            ],
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
