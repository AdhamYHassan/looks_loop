import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

class LookProductColorSwatches extends StatelessWidget {
  final List<ProductColorEntity> colors;
  final int? selectedColorId;
  final ValueChanged<int>? onColorSelected;

  const LookProductColorSwatches({
    super.key,
    required this.colors,
    this.selectedColorId,
    this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: colors.map((c) {
        final isSelected = c.id == selectedColorId;
        final parsed = ColorManager.parseHex(c.hex);
        return GestureDetector(
          onTap: onColorSelected != null ? () => onColorSelected!(c.id) : null,
          child: Container(
            width: 22.w,
            height: 22.h,
            margin: EdgeInsets.only(right: 6.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? ColorManager.getText(context)
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: parsed,
                shape: BoxShape.circle,
                border: Border.all(
                  color: parsed.computeLuminance() > 0.85
                      ? Colors.black26
                      : Colors.transparent,
                  width: 0.8,
                ),
              ),
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
  final String? selectedSize;
  final ValueChanged<String>? onSizeSelected;

  const LookProductSizesRow({
    super.key,
    required this.category,
    required this.subcategory,
    this.selectedSize,
    this.onSizeSelected,
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
          final isSelected = size == selectedSize;
          return GestureDetector(
            onTap: onSizeSelected != null ? () => onSizeSelected!(size) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.only(right: 6.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorManager.olive
                    : ColorManager.getSurface(context),
                borderRadius: BorderRadius.circular(2.r),
                border: Border.all(
                  color: isSelected
                      ? ColorManager.olive
                      : ColorManager.getBorder(context),
                ),
              ),
              child: Text(
                size,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : ColorManager.getText(context),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
