import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LookProductPriceRow extends StatelessWidget {
  final ProductEntity product;

  const LookProductPriceRow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.isOnSale && product.originalPrice != null) {
      return Row(
        children: [
          Text(
            '${product.price.toInt()} EGP',
            style: TextStyles.font13TextBold(context).copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(6.w),
          Text(
            '${product.originalPrice!.toInt()} EGP',
            style: TextStyles.font11MutedLineThrough(context),
          ),
          Gap(6.w),
          Text(
            '-${product.discountPercent}%',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: ColorManager.orange,
            ),
          ),
        ],
      );
    }
    return Text(
      '${product.price.toInt()} EGP',
      style: TextStyles.font13TextBold(context).copyWith(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class LookProductActionButtons extends StatelessWidget {
  final VoidCallback onAddToBag;
  final VoidCallback onViewProduct;
  final bool isAddingToBag;

  const LookProductActionButtons({
    super.key,
    required this.onAddToBag,
    required this.onViewProduct,
    this.isAddingToBag = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: ElevatedButton.icon(
            onPressed: isAddingToBag ? null : onAddToBag,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.olive,
              foregroundColor: Colors.white,
              disabledBackgroundColor:
                  ColorManager.olive.withValues(alpha: 0.7),
              disabledForegroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            icon: isAddingToBag
                ? SizedBox(
                    width: 12.sp,
                    height: 12.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5.w,
                      color: Colors.white,
                    ),
                  )
                : Icon(LucideIcons.shoppingBag, size: 13.sp),
            label: Text(
              isAddingToBag ? 'ADDING...' : 'ADD TO BAG',
              style: TextStyles.font11WhiteEyebrow.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        Gap(8.w),
        Expanded(
          flex: 6,
          child: OutlinedButton.icon(
            onPressed: onViewProduct,
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorManager.getText(context),
              side: BorderSide(color: ColorManager.getBorder(context)),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            iconAlignment: IconAlignment.end,
            icon: Icon(LucideIcons.arrowUpRight, size: 13.sp),
            label: Text(
              'VIEW PRODUCT',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
