import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ProductBadge extends StatelessWidget {
  final int discountPercent;

  const ProductBadge({super.key, required this.discountPercent});

  @override
  Widget build(BuildContext context) {
    final isDiscount = discountPercent > 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: isDiscount ? ColorManager.ink : ColorManager.olive,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Text(
        isDiscount ? '-$discountPercent%' : 'NEW',
        style: TextStyles.font10DiscountBadge,
      ),
    );
  }
}

