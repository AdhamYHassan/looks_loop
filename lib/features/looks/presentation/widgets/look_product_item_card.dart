import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/looks/presentation/widgets/look_product_actions.dart';
import 'package:looks_loop/features/looks/presentation/widgets/look_product_variants.dart';

class LookProductItemCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onViewProduct;
  final VoidCallback onAddToBag;

  const LookProductItemCard({
    super.key,
    required this.product,
    required this.onViewProduct,
    required this.onAddToBag,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: 110.w,
                height: 145.h,
                child: AppCachedImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  memCacheWidth: 350,
                  memCacheHeight: 450,
                ),
              ),
            ),
            Gap(14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    style: TextStyles.font11Eyebrow(context).copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 11.sp,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Gap(3.h),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font13TextBold(context).copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(5.h),
                  LookProductPriceRow(product: product),
                  if (product.colors.isNotEmpty) ...[
                    Gap(8.h),
                    LookProductColorSwatches(colors: product.colors),
                  ],
                  Gap(8.h),
                  LookProductSizesRow(
                    category: product.category,
                    subcategory: product.subcategory,
                  ),
                  Gap(12.h),
                  LookProductActionButtons(
                    onAddToBag: onAddToBag,
                    onViewProduct: onViewProduct,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Divider(
            height: 1,
            color: ColorManager.getBorder(context),
          ),
        ),
      ],
    );
  }
}
