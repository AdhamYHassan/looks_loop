import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_args.dart';
import 'package:looks_loop/features/product_list/presentation/bloc/product_list_cubit.dart';
import 'package:looks_loop/features/product_list/presentation/bloc/product_list_state.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_filter_bottom_sheet.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_list_filter_chips.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_list_grid.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_list_header.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_list_toolbar.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_list_category_rail.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_sort_bottom_sheet.dart';

class ProductListBody extends StatelessWidget {
  final ProductListArgs args;
  final ProductListLoaded state;
  final ScrollController scrollController;

  const ProductListBody({
    super.key,
    required this.args,
    required this.state,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductListCubit>();
    return RefreshIndicator(
      onRefresh: () async => cubit.loadProducts(
        category: state.category,
        subcategory: state.subcategory,
        sort: state.currentSort,
        q: state.searchQuery,
        filters: state.currentFilters,
      ),
      child: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: ProductListHeader(
              categoryTitle: args.categoryTitle.isNotEmpty
                  ? args.categoryTitle
                  : state.category,
              subcategoryTitle: args.subcategoryTitle.isNotEmpty
                  ? args.subcategoryTitle
                  : state.subcategory,
              count: state.data.count,
            ),
          ),
          if (args.category.isEmpty || args.isNew || args.isSale || args.isTrending)
            SliverToBoxAdapter(
              child: ProductListCategoryRail(
                currentCategory: state.category,
                onSelectCategory: cubit.filterByCategory,
              ),
            ),
          SliverToBoxAdapter(
            child: ProductListToolbar(
              activeFilterCount: state.currentFilters.activeFilterCount,
              onFilterTap: () => ProductFilterBottomSheet.show(
                context,
                facets: state.data.facets,
                currentFilters: state.currentFilters,
                onApply: cubit.applyFilters,
                isBrandFilterLocked: args.isBrandFilterLocked,
              ),
              onSortTap: () => ProductSortBottomSheet.show(
                context,
                options: state.data.sortOptions,
                currentSort: state.currentSort,
                onSelectSort: cubit.changeSort,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ProductListFilterChips(
              filters: state.currentFilters,
              onRemoveBrand: (b) {
                final updated =
                    List<String>.from(state.currentFilters.brands)..remove(b);
                cubit.applyFilters(
                  state.currentFilters.copyWith(brands: updated),
                );
              },
              onRemoveSize: (s) {
                final updated =
                    List<String>.from(state.currentFilters.sizes)..remove(s);
                cubit.applyFilters(
                  state.currentFilters.copyWith(sizes: updated),
                );
              },
              onRemoveColor: (c) {
                final updated =
                    List<String>.from(state.currentFilters.colors)..remove(c);
                cubit.applyFilters(
                  state.currentFilters.copyWith(colors: updated),
                );
              },
              onRemoveSale: () => cubit.applyFilters(
                state.currentFilters.copyWith(sale: false),
              ),
              onRemoveNewIn: () => cubit.applyFilters(
                state.currentFilters.copyWith(newIn: false),
              ),
              onClearAll: cubit.clearAllFilters,
            ),
          ),
          ProductListGrid(
            products: state.data.results,
            isLoadingMore: state.isLoadingMore,
            onProductTap: (item) {
              final slug = item.slug.isNotEmpty ? item.slug : item.id;
              context.push(Routes.productDetailPath(slug));
            },
          ),
          if (state.isLoadingMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.olive,
                    strokeWidth: 2.w,
                  ),
                ),
              ),
            ),
          SliverToBoxAdapter(child: Gap(20.h)),
        ],
      ),
    );
  }
}
