import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/nav_bar_item.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTabSelected,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (onTabSelected != null) {
      onTabSelected!(index);
      return;
    }
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        context.go(Routes.home);
        break;
      case 2:
        context.go(Routes.shop);
        break;
      case 3:
        context.go(Routes.wishlist);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final surfaceColor = ColorManager.getSurface(context);
    final borderColor = ColorManager.getBorder(context);
    final activeColor = ColorManager.getText(context);
    final inactiveColor = ColorManager.getTextMuted(context);

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
                    onTap: () => _onItemTapped(context, 0),
                  ),
                  NavBarItem(
                    icon: LucideIcons.play,
                    label: 'REELS',
                    isActive: currentIndex == 1,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => _onItemTapped(context, 1),
                  ),
                  NavBarItem(
                    icon: LucideIcons.shoppingBag,
                    label: 'SHOP',
                    isActive: currentIndex == 2,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => _onItemTapped(context, 2),
                  ),
                  NavBarItem(
                    icon: LucideIcons.heart,
                    label: 'WISHLIST',
                    isActive: currentIndex == 3,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => _onItemTapped(context, 3),
                  ),
                  NavBarItem(
                    icon: LucideIcons.layoutGrid,
                    label: 'MORE',
                    isActive: currentIndex == 4,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => _onItemTapped(context, 4),
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
  }
}
