import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:looks_loop/features/brands/presentation/bloc/brands_cubit.dart';
import 'package:looks_loop/features/brands/presentation/bloc/brands_state.dart';
import 'package:looks_loop/features/brands/presentation/widgets/az_brands_section.dart';
import 'package:looks_loop/features/brands/presentation/widgets/brands_error_view.dart';
import 'package:looks_loop/features/brands/presentation/widgets/brands_search_header.dart';
import 'package:looks_loop/features/brands/presentation/widgets/brands_skeleton_loader.dart';
import 'package:looks_loop/features/brands/presentation/widgets/brands_sub_nav_bar.dart';
import 'package:looks_loop/features/brands/presentation/widgets/featured_brands_section.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_args.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onBrandTap(BrandEntity brand) {
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

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BrandsCubit>();

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
                      const AnnouncementBar(
                        text: 'DISCOVER LOCAL & INTERNATIONAL BRANDS',
                      ),
                      BrandsSubNavBar(
                        onSearchTap: () => _searchFocusNode.requestFocus(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<BrandsCubit, BrandsState>(
                  builder: (context, state) {
                    return switch (state) {
                      BrandsInitial() || BrandsLoading() =>
                        const BrandsSkeletonLoader(),
                      BrandsError(:final message) => BrandsErrorView(
                          message: message,
                          onRetry: () => cubit.loadBrands(),
                        ),
                      BrandsLoaded() => RefreshIndicator(
                          onRefresh: () => cubit.loadBrands(),
                          color: ColorManager.olive,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BrandsSearchHeader(
                                  controller: _searchController,
                                  focusNode: _searchFocusNode,
                                  onChanged: cubit.searchBrands,
                                  onClear: cubit.clearSearch,
                                ),
                                if (state.searchQuery.isEmpty)
                                  FeaturedBrandsSection(
                                    brands: state.featuredBrands,
                                    onBrandTap: _onBrandTap,
                                  ),
                                AzBrandsSection(
                                  azBrands: state.azBrands,
                                  onBrandTap: _onBrandTap,
                                ),
                                Gap(30.h),
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
