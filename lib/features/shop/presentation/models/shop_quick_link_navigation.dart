import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_args.dart';

class ShopQuickLinkNavigation {
  ShopQuickLinkNavigation._();

  static void navigate(BuildContext context, String link) {
    switch (link.toUpperCase()) {
      case 'BRANDS':
        context.push(Routes.brands);
        break;

      case 'SALE':
        context.push(
          Routes.productList,
          extra: const ProductListArgs(
            category: 'sale',
            subcategory: '',
            categoryTitle: 'Sale',
            isSale: true,
          ),
        );
        break;

      case 'NEW IN':
        context.push(
          Routes.productList,
          extra: const ProductListArgs(
            category: '',
            subcategory: '',
            categoryTitle: 'New In',
            isNew: true,
          ),
        );
        break;

      case 'BEST SELLERS':
        context.push(
          Routes.productList,
          extra: const ProductListArgs(
            category: '',
            subcategory: '',
            categoryTitle: 'Best Sellers',
            isTrending: true,
          ),
        );
        break;
    }
  }
}
