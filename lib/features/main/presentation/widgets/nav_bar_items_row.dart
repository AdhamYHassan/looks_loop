import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/main/domain/entities/main_tab.dart';
import 'package:looks_loop/features/main/presentation/widgets/floating_nav_bar_item.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NavBarItemsRow extends StatelessWidget {
  final int selectedIndex;
  final bool isScrolled;
  final ValueChanged<MainTab> onTabSelected;
  final Color? activeColor;

  const NavBarItemsRow({
    super.key,
    required this.selectedIndex,
    required this.isScrolled,
    required this.onTabSelected,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? ColorManager.primary;
    final inactiveColor = ColorManager.getTextMuted(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingNavBarItem(
          icon: LucideIcons.house,
          label: 'HOME',
          isActive: selectedIndex == 0,
          isScrolled: isScrolled,
          activeColor: effectiveActiveColor,
          inactiveColor: inactiveColor,
          onTap: () => onTabSelected(MainTab.home),
        ),
        FloatingNavBarItem(
          icon: LucideIcons.shoppingBag,
          label: 'SHOP',
          isActive: selectedIndex == 2,
          isScrolled: isScrolled,
          activeColor: effectiveActiveColor,
          inactiveColor: inactiveColor,
          onTap: () => onTabSelected(MainTab.shop),
        ),
        FloatingNavBarItem(
          icon: LucideIcons.heart,
          label: 'WISHLIST',
          isActive: selectedIndex == 3,
          isScrolled: isScrolled,
          activeColor: effectiveActiveColor,
          inactiveColor: inactiveColor,
          onTap: () => onTabSelected(MainTab.wishlist),
        ),
        FloatingNavBarItem(
          icon: LucideIcons.layoutGrid,
          label: 'MORE',
          isActive: selectedIndex == 4,
          isScrolled: isScrolled,
          activeColor: effectiveActiveColor,
          inactiveColor: inactiveColor,
          onTap: () => onTabSelected(MainTab.more),
        ),
      ],
    );
  }
}
