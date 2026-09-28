import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/category_card.dart';
import 'package:looks_loop/features/home/presentation/widgets/section_header.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoryEntity> categories;
  final ValueChanged<CategoryEntity>? onCategoryTap;
  final VoidCallback? onViewAllTap;

  const CategoriesSection({
    super.key,
    required this.categories,
    this.onCategoryTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: '01 / DISCOVER',
          title: 'Find your next look',
          onActionTap: onViewAllTap,
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            children: categories.map((cat) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: CategoryCard(
                    category: cat,
                    onTap: () => onCategoryTap?.call(cat),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 28.h),
      ],
    );
  }
}
