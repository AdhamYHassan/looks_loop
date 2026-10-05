import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_bottom_nav_bar.dart';
import 'package:looks_loop/core/widgets/loaders/loaders.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_state.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/home/presentation/widgets/chasing_loop_preview_dialog.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_feed_view.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_top_bar.dart';

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
                      const AnnouncementBar(),
                      HomeTopBar(
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
                      HomeInitial() || HomeLoading() => Center(
                          child: ChasingLoopLoader(
                            size: 64.w,
                            color: ColorManager.olive,
                          ),
                        ),
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
                                child: const Text('Retry'),
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
