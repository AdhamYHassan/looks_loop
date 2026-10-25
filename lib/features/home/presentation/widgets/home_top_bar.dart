import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeTopBar extends StatelessWidget {
  final bool isScrolled;
  final VoidCallback? onSearchTap;
  final VoidCallback? onBagTap;
  final VoidCallback? onLoaderTap;
  final bool? showSearchIcon;

  const HomeTopBar({
    super.key,
    this.isScrolled = false,
    this.onSearchTap,
    this.onBagTap,
    this.onLoaderTap,
    this.showSearchIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      height: isScrolled ? 50.h : 56.h,
      decoration: BoxDecoration(
        color: isScrolled
            ? ColorManager.ink.withValues(alpha: 0.92)
            : ColorManager.ink,
        border: Border(
          bottom: BorderSide(
            color: isScrolled
                ? ColorManager.cream.withValues(alpha: 0.12)
                : Colors.transparent,
            width: 0.8.h,
          ),
        ),
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : const [],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          Row(
            children: [
              if (showSearchIcon == true) ...[
                IconButton(
                  icon: Icon(
                    LucideIcons.search,
                    color: ColorManager.cream,
                    size: 20.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.h),
                  onPressed: onSearchTap,
                ),
              ],
              SizedBox(width: 8.w),
              IconButton(
                icon: Icon(
                  LucideIcons.shoppingBag,
                  color: ColorManager.cream,
                  size: 20.sp,
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.h),
                onPressed: onBagTap,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/app_logo.png',
      height: 24.h,
      fit: BoxFit.contain,
      color: ColorManager.cream,
    );
  }
}
//TODO we neeed to prevernt the wishlist if not logged in to prevernt the req to server 