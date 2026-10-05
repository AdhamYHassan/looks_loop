import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CategorySubcatRow extends StatelessWidget {
  final SubCategoryEntity subcategory;
  final VoidCallback? onTap;

  const CategorySubcatRow({
    super.key,
    required this.subcategory,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorManager.getBorder(context),
              width: 1.h,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: ColorManager.getSurface(context),
              ),
              clipBehavior: Clip.antiAlias,
              child: AppCachedImage(
                imageUrl: subcategory.imageUrl,
                fit: BoxFit.cover,
                memCacheWidth: 200,
                memCacheHeight: 200,
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subcategory.name.toUpperCase(),
                    style: TextStyles.font13TextBold(context).copyWith(
                      fontSize: 13.sp,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(3.h),
                  Text(
                    tr('shop.products_count_short',
                        args: ['${subcategory.productCount}']),
                    style: TextStyles.font13MutedMedium(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 18.sp,
              color: ColorManager.getTextMuted(context),
            ),
          ],
        ),
      ),
    );
  }
}
