import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_browse_button.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_empty_view.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_header.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_item_card.dart';

class WishlistContent extends StatelessWidget {
  final List<ProductEntity> items;
  final ValueChanged<String>? onRemoveItem;
  final VoidCallback? onBrowseTap;
  final Future<void> Function()? onRefresh;

  const WishlistContent({
    super.key,
    required this.items,
    this.onRemoveItem,
    this.onBrowseTap,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorManager.olive,
      onRefresh: onRefresh ?? () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RepaintBoundary(child: WishlistHeader()),
            if (items.isEmpty)
              WishlistEmptyView(onBrowseTap: onBrowseTap)
            else ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    for (int i = 0; i < items.length; i++) ...[
                      if (i > 0) Gap(16.h),
                      RepaintBoundary(
                        child: WishlistItemCard(
                          product: items[i],
                          onRemove: () => onRemoveItem?.call(items[i].id),
                        ),
                      ),
                    ],
                    Gap(28.h),
                    WishlistBrowseButton(onTap: onBrowseTap),
                    Gap(40.h),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
