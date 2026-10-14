import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ProductDescriptionSection extends StatelessWidget {
  final String description;

  const ProductDescriptionSection({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PRODUCT DESCRIPTION',
          style: TextStyles.font11Eyebrow(context).copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          description,
          style: TextStyles.font13Regular(context).copyWith(
            height: 1.6,
            color: ColorManager.getText(context).withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
}
