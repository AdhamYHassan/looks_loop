import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_bottom_nav_bar.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_top_bar.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_cubit.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_state.dart';
import 'package:looks_loop/features/shop/presentation/widgets/shop_feed_content.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ShopCubit>()..fetchShopFeed(),
      child: const _ShopScreenContent(),
    );
  }
}

class _ShopScreenContent extends StatelessWidget {
  const _ShopScreenContent();

  @override
  Widget build(BuildContext context) {
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
                color: ColorManager.olive,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      AnnouncementBar(),
                      HomeTopBar(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<ShopCubit, ShopState>(
                  builder: (context, state) {
                    return switch (state) {
                      ShopInitial() || ShopLoading() => Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.olive,
                            strokeWidth: 2.w,
                          ),
                        ),
                      ShopError(:final message) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message,
                                style: TextStyles.font13TextBold(context).copyWith(
                                  color: Colors.red,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Gap(12.h),
                              ElevatedButton(
                                onPressed: () =>
                                    context.read<ShopCubit>().fetchShopFeed(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      ShopLoaded(
                        :final feedData,
                        :final selectedAudienceId,
                        :final selectedQuickLink,
                        :final wishlistedProductIds,
                      ) =>
                        ShopFeedContent(
                          feedData: feedData,
                          selectedAudienceId: selectedAudienceId,
                          selectedQuickLink: selectedQuickLink,
                          wishlistedIds: wishlistedProductIds,
                          onSelectAudience: (aud) => context
                              .read<ShopCubit>()
                              .selectAudience(aud.id),
                          onSelectQuickLink: (link) => context
                              .read<ShopCubit>()
                              .selectQuickLink(link),
                          onWishlistToggle: (id) => context
                              .read<ShopCubit>()
                              .toggleWishlist(id),
                          onRefresh: () =>
                              context.read<ShopCubit>().fetchShopFeed(),
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 2,
          onTabSelected: (index) {
            if (index == 0) {
              context.go(Routes.home);
            } else if (index == 3) {
              context.go(Routes.wishlist);
            }
          },
        ),
      ),
    );
  }
}
