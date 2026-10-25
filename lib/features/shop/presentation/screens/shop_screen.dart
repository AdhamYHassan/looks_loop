import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/app_bottom_nav_bar.dart';
import 'package:looks_loop/core/widgets/loaders/loaders.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_state.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_cubit.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_state.dart';
import 'package:looks_loop/features/shop/presentation/models/shop_feed_resolvers.dart';
import 'package:looks_loop/features/shop/presentation/models/shop_quick_link_navigation.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_error_view.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_feed_content.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_top_bar.dart';

class ShopScreen extends StatelessWidget {
  final bool showBottomNavBar;

  const ShopScreen({super.key, this.showBottomNavBar = true});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;
    final homeData = homeState is HomeLoaded ? homeState.feedData : null;

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
          bottom: false,
          child: Column(
            children: [
              const ShopTopBar(),
              Expanded(
                child: BlocBuilder<ShopCubit, ShopState>(
                  builder: (context, state) {
                    return switch (state) {
                      ShopInitial() || ShopLoading() => Center(
                        child: ChasingLoopLoader(
                          size: 64.w,
                          color: ColorManager.olive,
                        ),
                      ),
                      ShopError(:final message) => ShopErrorView(
                        message: message,
                        onRetry: () =>
                            context.read<ShopCubit>().fetchShopFeed(),
                      ),
                      ShopLoaded(
                        :final feedData,
                        :final selectedAudienceId,
                        :final selectedQuickLink,
                        :final wishlistedProductIds,
                      ) =>
                        ShopFeedContent(
                          feedData: feedData,
                          homeFeedData: homeData,
                          selectedAudienceId: selectedAudienceId,
                          selectedQuickLink: selectedQuickLink,
                          wishlistedIds: wishlistedProductIds,
                          onSelectAudience: (aud) {
                            context.read<ShopCubit>().selectAudience(aud.id);
                            ShopFeedResolvers.navigateToAudience(
                              context,
                              homeData: homeData,
                              audience: aud,
                              fallbackRail: feedData.newInProducts,
                            );
                          },
                          onCategoryTap: (subcat) =>
                              ShopFeedResolvers.navigateToSubcategory(
                                context,
                                homeData: homeData,
                                selectedAudienceId: selectedAudienceId,
                                subcat: subcat,
                              ),
                          onViewAllCategories: () =>
                              ShopFeedResolvers.navigateToViewAll(
                                context,
                                homeData: homeData,
                                selectedAudienceId: selectedAudienceId,
                                fallbackRail: feedData.newInProducts,
                              ),
                          onSelectQuickLink: (link) {
                            context.read<ShopCubit>().selectQuickLink(link);
                            ShopQuickLinkNavigation.navigate(context, link);
                          },

                          onWishlistToggle: (id) =>
                              context.read<ShopCubit>().toggleWishlist(id),
                          onProductTap: (product) {
                            final slug = product.slug.isNotEmpty
                                ? product.slug
                                : product.id;
                            if (slug.isNotEmpty) {
                              context.push(Routes.productDetailPath(slug));
                            }
                          },
                          onRefresh: () async {
                            await Future.wait([
                              context.read<ShopCubit>().fetchShopFeed(),
                              context.read<HomeCubit>().fetchHomeFeed(),
                            ]);
                          },
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: showBottomNavBar
            ? AppBottomNavBar(
                currentIndex: 2,
                onTabSelected: (index) {
                  if (index == 0) {
                    context.go(Routes.home);
                  } else if (index == 3) {
                    context.go(Routes.wishlist);
                  }
                },
              )
            : null,
      ),
    );
  }
}
