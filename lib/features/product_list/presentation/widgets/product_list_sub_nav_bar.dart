import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:looks_loop/features/product_list/presentation/widgets/product_list_search_field.dart';

class ProductListSubNavBar extends StatefulWidget {
  final String title;
  final int bagCount;
  final ValueChanged<String>? onSearchSubmitted;
  final VoidCallback? onSearchCleared;

  const ProductListSubNavBar({
    super.key,
    required this.title,
    this.bagCount = 0,
    this.onSearchSubmitted,
    this.onSearchCleared,
  });

  @override
  State<ProductListSubNavBar> createState() => _ProductListSubNavBarState();
}

class _ProductListSubNavBarState extends State<ProductListSubNavBar> {
  bool _isSearching = false;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      color: ColorManager.ink,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: _isSearching
          ? ProductListSearchField(
              controller: _controller,
              onSubmitted: widget.onSearchSubmitted,
              onClose: () {
                _controller.clear();
                widget.onSearchCleared?.call();
                setState(() => _isSearching = false);
              },
              onClear: () {
                _controller.clear();
                widget.onSearchCleared?.call();
              },
            )
          : _buildDefaultRow(),
    );
  }

  Widget _buildDefaultRow() {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            LucideIcons.arrowLeft,
            color: ColorManager.cream,
            size: 20.sp,
          ),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        Gap(4.w),
        Expanded(
          child: Text(
            widget.title.toUpperCase(),
            style: TextStyles.font13TextBold(context).copyWith(
              color: ColorManager.cream,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(LucideIcons.search, color: ColorManager.cream, size: 18.sp),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
          onPressed: () => setState(() => _isSearching = true),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: Icon(
                LucideIcons.shoppingBag,
                color: ColorManager.cream,
                size: 18.sp,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
              onPressed: () => context.push(Routes.cart),
            ),
            if (widget.bagCount > 0)
              Positioned(
                top: 6.h,
                right: 6.w,
                child: Container(
                  padding: EdgeInsets.all(3.r),
                  decoration: const BoxDecoration(
                    color: ColorManager.orange,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 15.w, minHeight: 15.h),
                  child: Text(
                    '${widget.bagCount}',
                    style: TextStyles.font10DiscountBadge.copyWith(
                      fontSize: 9.sp,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
