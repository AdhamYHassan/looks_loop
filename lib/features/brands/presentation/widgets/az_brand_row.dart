import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AzBrandRow extends StatelessWidget {
  final BrandEntity brand;
  final VoidCallback onTap;

  const AzBrandRow({
    super.key,
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = ColorManager.getText(context);
    final mutedColor = ColorManager.getTextMuted(context);
    final borderColor = ColorManager.getBorder(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor)),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: ColorManager.getSurface(context),
                shape: BoxShape.circle,
                border: Border.all(color: borderColor),
              ),
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              child: brand.logo.isNotEmpty
                  ? AppCachedImage(
                      imageUrl: brand.logo,
                      width: 36.w,
                      height: 36.w,
                      fit: BoxFit.contain,
                    )
                  : Text(
                      brand.name.isNotEmpty ? brand.name[0].toUpperCase() : 'B',
                      style: TextStyles.font14SemiBold(context),
                    ),
            ),
            Gap(14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand.name,
                    style: TextStyles.font14SemiBold(context).copyWith(
                      color: textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (brand.description.isNotEmpty) ...[
                    Gap(2.h),
                    Text(
                      brand.description,
                      style: TextStyles.font12Regular(context).copyWith(
                        color: mutedColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Gap(10.w),
            Text(
              '${brand.productCount}',
              style: TextStyles.font12Medium(context).copyWith(
                color: mutedColor,
              ),
            ),
            Gap(8.w),
            Icon(
              LucideIcons.chevronRight,
              size: 16.sp,
              color: mutedColor,
            ),
          ],
        ),
      ),
    );
  }
}
