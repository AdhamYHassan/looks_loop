import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductListFilterChips extends StatelessWidget {
  final SelectedFiltersEntity filters;
  final ValueChanged<String>? onRemoveBrand;
  final ValueChanged<String>? onRemoveSize;
  final ValueChanged<String>? onRemoveColor;
  final VoidCallback? onRemoveSale;
  final VoidCallback? onRemoveNewIn;
  final VoidCallback onClearAll;

  const ProductListFilterChips({
    super.key,
    required this.filters,
    this.onRemoveBrand,
    this.onRemoveSize,
    this.onRemoveColor,
    this.onRemoveSale,
    this.onRemoveNewIn,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    if (filters.activeFilterCount == 0) return const SizedBox.shrink();

    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          ...filters.brands.map(
            (b) => _buildChip(
              context,
              label: b.toUpperCase(),
              onDelete: () => onRemoveBrand?.call(b),
            ),
          ),
          ...filters.sizes.map(
            (s) => _buildChip(
              context,
              label: 'SIZE ${s.toUpperCase()}',
              onDelete: () => onRemoveSize?.call(s),
            ),
          ),
          ...filters.colors.map(
            (c) => _buildChip(
              context,
              label: c.toUpperCase(),
              onDelete: () => onRemoveColor?.call(c),
            ),
          ),
          if (filters.sale)
            _buildChip(
              context,
              label: 'SALE',
              onDelete: onRemoveSale,
            ),
          if (filters.newIn)
            _buildChip(
              context,
              label: 'NEW IN',
              onDelete: onRemoveNewIn,
            ),
          Gap(6.w),
          Center(
            child: InkWell(
              onTap: onClearAll,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Text(
                  'CLEAR ALL',
                  style: TextStyles.font11Eyebrow(context).copyWith(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    VoidCallback? onDelete,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: ColorManager.getSurface(context),
          borderRadius: BorderRadius.circular(2.r),
          border: Border.all(color: ColorManager.getBorder(context)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyles.font11Eyebrow(context).copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            Gap(6.w),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                LucideIcons.x,
                size: 11.sp,
                color: ColorManager.getText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
