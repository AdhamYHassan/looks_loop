import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    this.onTabSelected,
  });

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
                  _NavItem(
                    icon: LucideIcons.house,
                    label: 'HOME',
                    isActive: currentIndex == 0,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => onTabSelected?.call(0),
                  ),
                  _NavItem(
                    icon: LucideIcons.play,
                    label: 'REELS',
                    isActive: currentIndex == 1,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => onTabSelected?.call(1),
                  ),
                  _NavItem(
                    icon: LucideIcons.shoppingBag,
                    label: 'SHOP',
                    isActive: currentIndex == 2,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => onTabSelected?.call(2),
                  ),
                  _NavItem(
                    icon: LucideIcons.heart,
                    label: 'WISHLIST',
                    isActive: currentIndex == 3,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => onTabSelected?.call(3),
                  ),
                  _NavItem(
                    icon: LucideIcons.layoutGrid,
                    label: 'MORE',
                    isActive: currentIndex == 4,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onTap: () => onTabSelected?.call(4),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Container(
              width: 120.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 6.h),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22.sp, color: color),
          SizedBox(height: 3.h),
          Text(
            label,
            style: TextStyles.font9NavLabel(isActive: isActive, color: color),
          ),
        ],
      ),
    );
  }
}
