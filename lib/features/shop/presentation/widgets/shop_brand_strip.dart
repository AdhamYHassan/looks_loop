import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/presentation/widgets/section_header.dart';

class ShopBrandStrip extends StatelessWidget {
  final List<BrandEntity> brands;
  final ValueChanged<BrandEntity>? onBrandTap;
  final VoidCallback? onViewAllTap;

  const ShopBrandStrip({
    super.key,
    required this.brands,
    this.onBrandTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(24.h),
        SectionHeader(
          eyebrow: 'DISCOVER',
          title: 'BRANDS TO DISCOVER',
          actionLabel: 'VIEW ALL',
          onActionTap: onViewAllTap,
        ),
        Gap(4.h),
        SizedBox(
          height: 60.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            separatorBuilder: (_, _) => Gap(10.w),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return _BrandTile(
                brand: brand,
                onTap: () => onBrandTap?.call(brand),
              );
            },
          ),
        ),
        Gap(40.h),
      ],
    );
  }
}

class _BrandTile extends StatelessWidget {
  final BrandEntity brand;
  final VoidCallback? onTap;

  const _BrandTile({required this.brand, this.onTap});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = ColorManager.getSurface(context);
    final borderColor = ColorManager.getBorder(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: surfaceColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(4.r),
        ),
        alignment: Alignment.center,
        child: Text(
          brand.name.toUpperCase(),
          style: TextStyles.font12Brand(context),
        ),
      ),
    );
  }
}
