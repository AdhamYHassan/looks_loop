import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_cubit.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_state.dart';
import 'package:looks_loop/features/main/presentation/bloc/nav_bar_scroll_cubit.dart';
import 'package:looks_loop/features/main/presentation/bloc/nav_bar_scroll_state.dart';
import 'package:looks_loop/features/main/presentation/widgets/nav_bar_items_row.dart';

class DynamicFloatingNavBar extends StatelessWidget {
  const DynamicFloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);
    final surfaceColor = ColorManager.getSurface(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final borderRadius = BorderRadius.circular(32.r);

    return BlocBuilder<NavBarScrollCubit, NavBarScrollState>(
      buildWhen: (prev, curr) => prev.isScrolled != curr.isScrolled,
      builder: (context, scrollState) {
        final isScrolled = scrollState.isScrolled;

        // Scrolled mode: higher transparency (lower alpha), stronger blur (18.0)
        // Non-scrolled mode: lower transparency (higher alpha), subtle blur (8.0)
        final targetBlur = isScrolled ? 18.0 : 8.0;
        final targetAlpha = isScrolled
            ? (isDark ? 0.48 : 0.40)
            : (isDark ? 0.80 : 0.75);
        final targetBorderColor = isScrolled
            ? (isDark
                ? Colors.white.withValues(alpha: 0.20)
                : Colors.white.withValues(alpha: 0.70))
            : (isDark
                ? Colors.white.withValues(alpha: 0.10)
                : Colors.white.withValues(alpha: 0.45));

        return RepaintBoundary(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            margin: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              bottom: bottomInset > 0 ? bottomInset + 2.h : 14.h,
            ),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: isScrolled
                        ? (isDark ? 0.35 : 0.10)
                        : (isDark ? 0.20 : 0.06),
                  ),
                  blurRadius: isScrolled ? 24 : 14,
                  offset: Offset(0, isScrolled ? 8 : 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(end: targetBlur),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                builder: (context, blurSigma, child) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: blurSigma,
                      sigmaY: blurSigma,
                    ),
                    child: child,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  padding: EdgeInsets.symmetric(
                    vertical: isScrolled ? 6.h : 9.h,
                  ),
                  decoration: BoxDecoration(
                    color: surfaceColor.withValues(alpha: targetAlpha),
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: targetBorderColor,
                      width: 1.2.w,
                    ),
                  ),
                  child: BlocBuilder<MainCubit, MainState>(
                    buildWhen: (prev, curr) =>
                        prev.currentTab != curr.currentTab,
                    builder: (context, mainState) {
                      return NavBarItemsRow(
                        selectedIndex: mainState.selectedIndex,
                        isScrolled: isScrolled,
                        onTabSelected: (tab) =>
                            context.read<MainCubit>().changeTab(tab),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
