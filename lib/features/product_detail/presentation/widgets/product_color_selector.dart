import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

class ProductColorSelector extends StatelessWidget {
  final List<ProductColorEntity> colors;
  final int? selectedColorId;
  final ValueChanged<int> onColorSelected;

  const ProductColorSelector({
    super.key,
    required this.colors,
    required this.selectedColorId,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) return const SizedBox.shrink();

    final activeColor = colors.firstWhere(
      (c) => c.id == selectedColorId,
      orElse: () => colors.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COLOR: ${activeColor.name.toUpperCase()}',
          style: TextStyles.font11Eyebrow(context).copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: colors.map((color) {
            final isSelected = color.id == selectedColorId;
            final parsedColor = _parseHex(color.hex);

            return GestureDetector(
              onTap: () => onColorSelected(color.id),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? ColorManager.getText(context)
                        : Colors.transparent,
                    width: 1.5.w,
                  ),
                ),
                child: Container(
                  width: 26.w,
                  height: 26.h,
                  decoration: BoxDecoration(
                    color: parsedColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.getBorder(context),
                      width: 1.w,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _parseHex(String hex) {
    try {
      final clean = hex.replaceAll('#', '').trim();
      if (clean.length == 6) {
        return Color(int.parse('0xFF$clean'));
      } else if (clean.startsWith('0x') || clean.startsWith('0X')) {
        return Color(int.parse(clean));
      } else if (clean.length == 8) {
        return Color(int.parse('0x$clean'));
      }
    } catch (_) {}
    return const Color(0xFF1A1A1A);
  }
}
