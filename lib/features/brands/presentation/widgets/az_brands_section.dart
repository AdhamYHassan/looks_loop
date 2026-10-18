import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:looks_loop/features/brands/presentation/widgets/az_brand_row.dart';

class AzBrandsSection extends StatelessWidget {
  final Map<String, List<BrandEntity>> azBrands;
  final ValueChanged<BrandEntity> onBrandTap;

  const AzBrandsSection({
    super.key,
    required this.azBrands,
    required this.onBrandTap,
  });

  @override
  Widget build(BuildContext context) {
    if (azBrands.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 30.h),
        child: Center(
          child: Text(
            'No brands found',
            style: TextStyles.font14Medium(context).copyWith(
              color: ColorManager.getTextMuted(context),
            ),
          ),
        ),
      );
    }

    final sortedKeys = azBrands.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Text(
            'ALL BRANDS',
            style: TextStyles.font11Eyebrow(context).copyWith(
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Gap(6.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedKeys.length,
          itemBuilder: (context, index) {
            final letter = sortedKeys[index];
            final brands = azBrands[letter] ?? const [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 6.h,
                  ),
                  color: ColorManager.getSurface(context).withValues(alpha: 0.5),
                  child: Text(
                    letter,
                    style: TextStyles.font12Medium(context).copyWith(
                      fontWeight: FontWeight.w800,
                      color: ColorManager.olive,
                    ),
                  ),
                ),
                ...brands.map(
                  (brand) => AzBrandRow(
                    brand: brand,
                    onTap: () => onBrandTap(brand),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
