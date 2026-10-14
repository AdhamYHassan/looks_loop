import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ProductFilterApplyButton extends StatelessWidget {
  final VoidCallback onApply;

  const ProductFilterApplyButton({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
      child: SizedBox(
        width: double.infinity,
        height: 46.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.ink,
            foregroundColor: ColorManager.cream,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          onPressed: onApply,
          child: Text(
            'APPLY FILTERS',
            style: TextStyles.font11BlackCta.copyWith(
              color: ColorManager.cream,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
