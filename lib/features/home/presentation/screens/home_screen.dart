import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_bottom_nav_bar.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_state.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/home/presentation/widgets/chasing_loop_preview_dialog.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_feed_skeleton_loader.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_feed_view.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_top_bar.dart';
import 'package:looks_loop/features/main/presentation/bloc/nav_bar_scroll_cubit.dart';

class HomeScreen extends StatefulWidget {
  final bool showBottomNavBar;

  const HomeScreen({
    super.key,
    this.showBottomNavBar = true,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isScrolled = false;
    try {
      isScrolled = context.select<NavBarScrollCubit, bool>(
        (cubit) => cubit.state.isScrolled,
      );
    } catch (_) {}

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
              Container(
                color: ColorManager.olive,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSize(
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeInOutCubic,
                        child: SizedBox(
                          height: isScrolled ? 0 : null,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: isScrolled ? 0.0 : 1.0,
                            child: const AnnouncementBar(),
                          ),
                        ),
                      ),
                      HomeTopBar(
                        isScrolled: isScrolled,
                        onBagTap: () => context.push(Routes.cart),
                        onLoaderTap: () =>
                            ChasingLoopPreviewDialog.show(context),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return switch (state) {
                      HomeInitial() ||
                      HomeLoading() =>
                        const HomeFeedSkeletonLoader(),
                      HomeError(:final message) => Center(
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
                              SizedBox(height: 12.h),
                              ElevatedButton(
                                onPressed: () =>
                                    context.read<HomeCubit>().fetchHomeFeed(),
                                child: Text('common.retry'.tr()),
                              ),
                            ],
                          ),
                        ),
                      HomeLoaded(
                        :final feedData,
                        :final wishlistedProductIds,
                      ) =>
                        HomeFeedView(
                          feedData: feedData,
                          wishlistedIds: wishlistedProductIds,
                          onWishlistToggle: (id) =>
                              context.read<HomeCubit>().toggleWishlist(id),
                          onRefresh: () =>
                              context.read<HomeCubit>().fetchHomeFeed(),
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: widget.showBottomNavBar
            ? AppBottomNavBar(
                currentIndex: _currentTabIndex,
                onTabSelected: (index) {
                  setState(() => _currentTabIndex = index);
                  if (index == 2) {
                    context.push(Routes.shop);
                  } else if (index == 3) {
                    context.push(Routes.wishlist);
                  }
                },
              )
            : null,
      ),
    );
  }
}
