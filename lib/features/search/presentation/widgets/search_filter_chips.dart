import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/search/domain/entities/search_result_entity.dart';

class SearchFilterChips extends StatelessWidget {
  final List<SearchBrandEntity> brands;
  final List<SearchCategoryEntity> categories;
  final ValueChanged<SearchBrandEntity>? onBrandTap;
  final ValueChanged<SearchCategoryEntity>? onCategoryTap;

  const SearchFilterChips({
    super.key,
    this.brands = const [],
    this.categories = const [],
    this.onBrandTap,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty && categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 38.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          ...categories.map(
            (category) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ActionChip(
                label: Text('Category: ${category.name}'),
                labelStyle: TextStyles.font12Medium(context).copyWith(
                  color: ColorManager.olive,
                ),
                backgroundColor: ColorManager.olive.withValues(alpha: 0.1),
                side: BorderSide(
                  color: ColorManager.olive.withValues(alpha: 0.25),
                  width: 0.8.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                onPressed: () => onCategoryTap?.call(category),
              ),
            ),
          ),
          ...brands.map(
            (brand) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ActionChip(
                label: Text('Brand: ${brand.name}'),
                labelStyle: TextStyles.font12Medium(context).copyWith(
                  color: ColorManager.orange,
                ),
                backgroundColor: ColorManager.orange.withValues(alpha: 0.1),
                side: BorderSide(
                  color: ColorManager.orange.withValues(alpha: 0.25),
                  width: 0.8.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                onPressed: () => onBrandTap?.call(brand),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
