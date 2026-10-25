import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/cache/catalog_cache.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ProductListCategoryRail extends StatelessWidget {
  final String currentCategory;
  final ValueChanged<String> onSelectCategory;

  const ProductListCategoryRail({
    super.key,
    required this.currentCategory,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    final catalogCache = getIt<CatalogCache>();
    final categories = catalogCache.categories;

    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    final isAllSelected = currentCategory.isEmpty || currentCategory == 'all';

    return Container(
      height: 42.h,
      margin: EdgeInsets.only(bottom: 8.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _CategoryChip(
              title: 'ALL',
              isSelected: isAllSelected,
              onTap: () => onSelectCategory(''),
            );
          }

          final cat = categories[index - 1];
          final slug = cat.slug.isNotEmpty ? cat.slug : cat.name.toLowerCase();
          final isSelected = currentCategory.toLowerCase() == slug.toLowerCase();

          return _CategoryChip(
            title: cat.name.toUpperCase(),
            isSelected: isSelected,
            onTap: () => onSelectCategory(slug),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.olive : ColorManager.getSurface(context),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.olive
                : ColorManager.getBorder(context),
            width: 0.8.w,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyles.font12Medium(context).copyWith(
            color: isSelected ? ColorManager.cream : ColorManager.getText(context),
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
