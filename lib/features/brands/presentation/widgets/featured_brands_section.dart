import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:looks_loop/features/brands/presentation/widgets/featured_brand_card.dart';

class FeaturedBrandsSection extends StatelessWidget {
  final List<BrandEntity> brands;
  final ValueChanged<BrandEntity> onBrandTap;

  const FeaturedBrandsSection({
    super.key,
    required this.brands,
    required this.onBrandTap,
  });

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Text(
            'FEATURED BRANDS',
            style: TextStyles.font11Eyebrow(context).copyWith(
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Gap(10.h),
        SizedBox(
          height: 136.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            separatorBuilder: (_, _) => Gap(10.w),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return FeaturedBrandCard(
                brand: brand,
                onTap: () => onBrandTap(brand),
              );
            },
          ),
        ),
        Gap(20.h),
      ],
    );
  }
}
