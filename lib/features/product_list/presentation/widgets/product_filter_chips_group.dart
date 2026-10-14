import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ProductFilterChipsGroup extends StatelessWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<String> onToggle;
  final String Function(String item)? labelBuilder;

  const ProductFilterChipsGroup({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onToggle,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.font11Eyebrow(context).copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        Gap(8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            final label = labelBuilder != null ? labelBuilder!(item) : item;
            return InkWell(
              onTap: () => onToggle(item),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : ColorManager.getText(context),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Gap(20.h),
      ],
    );
  }
}
