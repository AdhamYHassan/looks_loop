import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductSortBottomSheet extends StatelessWidget {
  final List<SortOptionEntity> options;
  final String currentSort;
  final ValueChanged<String> onSelectSort;

  const ProductSortBottomSheet({
    super.key,
    required this.options,
    required this.currentSort,
    required this.onSelectSort,
  });

  static Future<void> show(
    BuildContext context, {
    required List<SortOptionEntity> options,
    required String currentSort,
    required ValueChanged<String> onSelectSort,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.getBackground(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => ProductSortBottomSheet(
        options: options,
        currentSort: currentSort,
        onSelectSort: onSelectSort,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.getBorder(context),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Gap(16.h),
            Text(
              'SORT BY',
              style: TextStyles.font13TextBold(context).copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gap(12.h),
            ...options.map((opt) {
              final isSelected = opt.value == currentSort;
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  onSelectSort(opt.value);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        opt.label.toUpperCase(),
                        style: TextStyles.font13TextBold(context).copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w500,
                          color: isSelected
                              ? ColorManager.getText(context)
                              : ColorManager.getTextMuted(context),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          LucideIcons.check,
                          size: 18.sp,
                          color: ColorManager.getText(context),
                        ),
                    ],
                  ),
                ),
              );
            }),
            Gap(8.h),
          ],
        ),
      ),
    );
  }
}
