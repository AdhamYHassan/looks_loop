import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';

class ProductFilterColorChipsGroup extends StatelessWidget {
  final List<ColorFacetEntity> colors;
  final List<String> selectedColors;
  final ValueChanged<String> onToggle;

  const ProductFilterColorChipsGroup({
    super.key,
    required this.colors,
    required this.selectedColors,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COLORS',
          style: TextStyles.font11Eyebrow(context).copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        Gap(8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: colors.map((item) {
            final isSelected = selectedColors.contains(item.name);
            return _ColorChipItem(
              key: ValueKey(item.name),
              item: item,
              isSelected: isSelected,
              onTap: () => onToggle(item.name),
            );
          }).toList(growable: false),
        ),
        Gap(20.h),
      ],
    );
  }
}

class _ColorChipItem extends StatelessWidget {
  final ColorFacetEntity item;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorChipItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final swatchColor = ColorManager.parseHex(item.hex);
    final isLight = swatchColor.computeLuminance() > 0.85;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.ink
              : ColorManager.getSurface(context),
          borderRadius: BorderRadius.circular(2.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.ink
                : ColorManager.getBorder(context),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.hex.isNotEmpty) ...[
              Container(
                width: 14.r,
                height: 14.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: swatchColor,
                  border: Border.all(
                    color: isLight
                        ? (isSelected ? Colors.white38 : Colors.black26)
                        : Colors.transparent,
                    width: 0.8.w,
                  ),
                ),
              ),
              Gap(7.w),
            ],
            Text(
              item.name,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : ColorManager.getText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
