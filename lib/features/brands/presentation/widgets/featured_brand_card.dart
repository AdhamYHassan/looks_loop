import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';

class FeaturedBrandCard extends StatelessWidget {
  final BrandEntity brand;
  final VoidCallback onTap;

  const FeaturedBrandCard({
    super.key,
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceColor = ColorManager.getSurface(context);
    final borderColor = ColorManager.getBorder(context);
    final mutedColor = ColorManager.getTextMuted(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: ColorManager.getBackground(context),
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              child: brand.logo.isNotEmpty
                  ? AppCachedImage(
                      imageUrl: brand.logo,
                      width: 44.w,
                      height: 44.w,
                      fit: BoxFit.contain,
                    )
                  : Text(
                      brand.name.isNotEmpty ? brand.name[0].toUpperCase() : 'B',
                      style: TextStyles.font18SemiBold(context),
                    ),
            ),
            Gap(10.h),
            Text(
              brand.name,
              style: TextStyles.font13TextBold(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Gap(2.h),
            Text(
              '${brand.productCount} products',
              style: TextStyles.font12Regular(context).copyWith(
                color: mutedColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
