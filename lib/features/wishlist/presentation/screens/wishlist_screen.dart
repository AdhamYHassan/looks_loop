import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_bottom_nav_bar.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_top_bar.dart';
import 'package:looks_loop/features/main/domain/entities/main_tab.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_content.dart';

class WishlistScreen extends StatelessWidget {
  final bool showBottomNavBar;

  const WishlistScreen({
    super.key,
    this.showBottomNavBar = true,
  });

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
                child: BlocBuilder<WishlistCubit, WishlistState>(
                  builder: (context, state) {
                    return switch (state) {
                      WishlistInitial() || WishlistLoading() => Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.olive,
                            strokeWidth: 2.w,
                          ),
                        ),
                      WishlistError(:final message) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message,
                                style:
                                    TextStyles.font13TextBold(context).copyWith(
                                  color: Colors.red,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Gap(12.h),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<WishlistCubit>()
                                    .fetchWishlist(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      WishlistLoaded(:final items) => WishlistContent(
                          items: items,
                          onRemoveItem: (id) =>
                              context.read<WishlistCubit>().removeItem(id),
                          onBrowseTap: () {
                            try {
                              context
                                  .read<MainCubit>()
                                  .changeTab(MainTab.shop);
                            } catch (_) {
                              context.go(Routes.shop);
                            }
                          },
                          onRefresh: () =>
                              context.read<WishlistCubit>().fetchWishlist(),
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
                currentIndex: 3,
                onTabSelected: (index) {
                  if (index == 0) {
                    context.go(Routes.home);
                  } else if (index == 2) {
                    context.go(Routes.shop);
                  }
                },
              )
            : null,
      ),
    );
  }
}
