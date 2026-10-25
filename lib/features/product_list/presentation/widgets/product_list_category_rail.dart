import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
      height: 32.h,
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (_, _) => Gap(8.w),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _EditorialCategoryTab(
              title: 'ALL',
              isSelected: isAllSelected,
              onTap: () => onSelectCategory(''),
            );
          }

          final cat = categories[index - 1];
          final slug = cat.slug.isNotEmpty ? cat.slug : cat.name.toLowerCase();
          final isSelected = currentCategory.toLowerCase() == slug.toLowerCase();

          return _EditorialCategoryTab(
            title: cat.name.toUpperCase(),
            isSelected: isSelected,
            onTap: () => onSelectCategory(slug),
          );
        },
      ),
    );
  }
}

class _EditorialCategoryTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _EditorialCategoryTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceColor = ColorManager.getSurface(context);
    final borderColor = ColorManager.getBorder(context);
    final activeBg = ColorManager.isDark(context) ? ColorManager.olive : ColorManager.ink;
    final activeText = ColorManager.cream;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeBg : surfaceColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: isSelected ? activeBg : borderColor,
            width: 0.8.w,
          ),
        ),
        child: Text(
          title,
          style: TextStyles.font11Action(context).copyWith(
            color: isSelected ? activeText : ColorManager.getTextMuted(context),
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
