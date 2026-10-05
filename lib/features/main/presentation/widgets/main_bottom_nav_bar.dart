import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/nav_bar_item.dart';
import 'package:looks_loop/features/main/domain/entities/main_tab.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_cubit.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_state.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = ColorManager.getSurface(context);
    final borderColor = ColorManager.getBorder(context);
    final activeColor = ColorManager.getText(context);
    final inactiveColor = ColorManager.getTextMuted(context);

    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final currentIndex = state.selectedIndex;

        return Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            border: Border(top: BorderSide(color: borderColor, width: 1.h)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NavBarItem(
                        icon: LucideIcons.house,
                        label: 'HOME',
                        isActive: currentIndex == 0,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        onTap: () => _selectTab(context, MainTab.home),
                      ),
                      // NavBarItem(
                      //   icon: LucideIcons.play,
                      //   label: 'REELS',
                      //   isActive: currentIndex == 1,
                      //   activeColor: activeColor,
                      //   inactiveColor: inactiveColor,
                      //   onTap: () => _selectTab(context, MainTab.reels),
                      // ),
                      NavBarItem(
                        icon: LucideIcons.shoppingBag,
                        label: 'SHOP',
                        isActive: currentIndex == 2,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        onTap: () => _selectTab(context, MainTab.shop),
                      ),
                      NavBarItem(
                        icon: LucideIcons.heart,
                        label: 'WISHLIST',
                        isActive: currentIndex == 3,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        onTap: () => _selectTab(context, MainTab.wishlist),
                      ),
                      NavBarItem(
                        icon: LucideIcons.layoutGrid,
                        label: 'MORE',
                        isActive: currentIndex == 4,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        onTap: () => _selectTab(context, MainTab.more),
                      ),
                    ],
                  ),
                ),
                Gap(4.h),
                Container(
                  width: 120.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Gap(6.h),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectTab(BuildContext context, MainTab tab) {
    context.read<MainCubit>().changeTab(tab);
  }
}
