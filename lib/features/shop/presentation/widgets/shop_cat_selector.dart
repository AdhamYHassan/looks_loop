import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ShopCatSelector extends StatelessWidget {
  final List<ShopAudienceEntity> audiences;
  final ValueChanged<ShopAudienceEntity>? onSelectAudience;

  const ShopCatSelector({
    super.key,
    required this.audiences,
    this.onSelectAudience,
  });

  @override
  Widget build(BuildContext context) {
    if (audiences.isEmpty) return const SizedBox.shrink();

    ShopAudienceEntity largeItem = audiences.first;
    for (final a in audiences) {
      if (a.isLarge) {
        largeItem = a;
        break;
      }
    }
    final halfItems = audiences.where((a) => a != largeItem).toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _AudienceTile(
            item: largeItem,
            height: 235.h,
            isLarge: true,
            onTap: () => onSelectAudience?.call(largeItem),
          ),
          if (halfItems.isNotEmpty) ...[
            Gap(10.h),
            Row(
              children: [
                for (int i = 0; i < halfItems.length; i++) ...[
                  if (i > 0) Gap(10.w),
                  Expanded(
                    child: _AudienceTile(
                      item: halfItems[i],
                      height: 155.h,
                      isLarge: false,
                      onTap: () => onSelectAudience?.call(halfItems[i]),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _AudienceTile extends StatelessWidget {
  final ShopAudienceEntity item;
  final double height;
  final bool isLarge;
  final VoidCallback? onTap;

  const _AudienceTile({
    required this.item,
    required this.height,
    required this.isLarge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Colors.grey.shade300,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(
              imageUrl: item.imageUrl,
              fit: BoxFit.fill,
              alignment: isLarge ? Alignment.topCenter : Alignment.center,
              memCacheWidth: isLarge ? 800 : 500,
              memCacheHeight: isLarge ? 500 : 350,
              maxDiskWidth: 1000,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color.fromRGBO(22, 29, 17, 0.65),
                  ],
                  stops: [0.45, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 14.w,
              bottom: 14.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: isLarge
                        ? TextStyles.font22WhiteSemiBold
                        : TextStyles.font16WhiteSemiBold,
                  ),
                  if (isLarge) ...[
                    Gap(6.w),
                    Icon(
                      LucideIcons.arrowUpRight,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
