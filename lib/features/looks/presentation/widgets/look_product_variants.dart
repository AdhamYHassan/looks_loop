import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

class LookProductColorSwatches extends StatelessWidget {
  final List<ProductColorEntity> colors;

  const LookProductColorSwatches({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: colors.map((c) {
        final parsed = ColorManager.parseHex(c.hex);
        return Container(
          width: 18.w,
          height: 18.h,
          margin: EdgeInsets.only(right: 6.w),
          decoration: BoxDecoration(
            color: parsed,
            borderRadius: BorderRadius.circular(2.r),
            border: Border.all(
              color: parsed.computeLuminance() > 0.85
                  ? Colors.black26
                  : Colors.transparent,
              width: 0.8,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class LookProductSizesRow extends StatelessWidget {
  final String category;
  final String subcategory;

  const LookProductSizesRow({
    super.key,
    required this.category,
    required this.subcategory,
  });

  @override
  Widget build(BuildContext context) {
    final isShoe = subcategory.toLowerCase().contains('shoe') ||
        category.toLowerCase().contains('shoe');
    final sizes = isShoe
        ? const ['36', '37', '38', '39', '40', '41', '42']
        : const ['XS', 'S', 'M', 'L', 'XL'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: sizes.map((size) {
          return Container(
            margin: EdgeInsets.only(right: 5.w),
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.r),
              border: Border.all(color: ColorManager.getBorder(context)),
            ),
            child: Text(
              size,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.getText(context),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
