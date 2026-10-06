import 'package:easy_localization/easy_localization.dart';
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
import 'package:looks_loop/features/more/presentation/bloc/more_cubit.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_state.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_content.dart';

class MoreScreen extends StatelessWidget {
  final bool showBottomNavBar;

  const MoreScreen({
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
                    children: [
                      AnnouncementBar(text: 'more.easy_returns'.tr()),
                      const HomeTopBar(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<MoreCubit, MoreState>(
                  builder: (context, state) {
                    return switch (state) {
                      MoreInitial() || MoreLoading() => Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.olive,
                            strokeWidth: 2.w,
                          ),
                        ),
                      MoreError(:final message) => Center(
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
                                    .read<MoreCubit>()
                                    .loadUserProfile(),
                                child: Text('common.retry'.tr()),
                              ),
                            ],
                          ),
                        ),
                      MoreLoaded(:final profile) => MoreContent(
                          profile: profile,
                          onRefresh: () =>
                              context.read<MoreCubit>().loadUserProfile(),
                          onSignInTap: () async {
                            await context.push(Routes.login);
                            if (context.mounted) {
                              context.read<MoreCubit>().loadUserProfile();
                            }
                          },
                          onSignOutTap: () =>
                              context.read<MoreCubit>().logout(),
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
                currentIndex: 4,
                onTabSelected: (index) {
                  if (index == 0) {
                    context.go(Routes.home);
                  } else if (index == 2) {
                    context.go(Routes.shop);
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
