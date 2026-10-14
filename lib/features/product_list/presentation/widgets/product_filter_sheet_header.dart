import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ProductFilterSheetHeader extends StatelessWidget {
  final VoidCallback onReset;

  const ProductFilterSheetHeader({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FILTERS',
                style: TextStyles.font13TextBold(context).copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              TextButton(
                onPressed: onReset,
                child: Text(
                  'RESET',
                  style: TextStyles.font11Eyebrow(context).copyWith(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1.h, color: ColorManager.getBorder(context)),
      ],
    );
  }
}
