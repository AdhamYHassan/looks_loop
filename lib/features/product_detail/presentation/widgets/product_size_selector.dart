import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_size_entity.dart';

class ProductSizeSelector extends StatelessWidget {
  final List<ProductSizeEntity> sizes;
  final int? selectedSizeId;
  final bool Function(int sizeId) isSizeAvailable;
  final ValueChanged<int> onSizeSelected;
  final VoidCallback? onSizeGuideTap;

  const ProductSizeSelector({
    super.key,
    required this.sizes,
    required this.selectedSizeId,
    required this.isSizeAvailable,
    required this.onSizeSelected,
    this.onSizeGuideTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SELECT SIZE',
              style: TextStyles.font11Eyebrow(context).copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            GestureDetector(
              onTap: onSizeGuideTap,
              child: Text(
                'SIZE GUIDE',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  decoration: TextDecoration.underline,
                  color: ColorManager.getTextMuted(context),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: sizes.map((size) {
            final isSelected = size.id == selectedSizeId;
            final isAvailable = isSizeAvailable(size.id);

            return GestureDetector(
              onTap: isAvailable ? () => onSizeSelected(size.id) : null,
              child: Container(
                width: 48.w,
                height: 44.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManager.getText(context)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? ColorManager.getText(context)
                        : isAvailable
                            ? ColorManager.getBorder(context)
                            : ColorManager.getBorder(context)
                                .withValues(alpha: 0.3),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  size.label,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: !isAvailable
                        ? ColorManager.getTextMuted(context)
                            .withValues(alpha: 0.4)
                        : isSelected
                            ? ColorManager.getBackground(context)
                            : ColorManager.getText(context),
                    decoration: isAvailable
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
