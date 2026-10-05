import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:looks_loop/features/shop/presentation/widgets/category_subcat_row.dart';

class CategorySubcatList extends StatelessWidget {
  final List<SubCategoryEntity> subcategories;
  final ValueChanged<SubCategoryEntity>? onSubcatTap;

  const CategorySubcatList({
    super.key,
    required this.subcategories,
    this.onSubcatTap,
  });

  @override
  Widget build(BuildContext context) {
    if (subcategories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 8.h),
          child: Text(
            tr('shop.shop_by_category'),
            style: TextStyles.font11Eyebrow(context).copyWith(
              fontSize: 11.sp,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: subcategories.length,
          itemBuilder: (context, index) {
            final subcat = subcategories[index];
            return CategorySubcatRow(
              subcategory: subcat,
              onTap: () => onSubcatTap?.call(subcat),
            );
          },
        ),
      ],
    );
  }
}
