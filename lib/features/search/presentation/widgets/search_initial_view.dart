import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SearchInitialView extends StatelessWidget {
  const SearchInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.sparkles,
            size: 36.sp,
            color: ColorManager.olive.withValues(alpha: 0.5),
          ),
          SizedBox(height: 12.h),
          Text(
            'Explore the Collection',
            style: TextStyles.font14Medium(context),
          ),
          SizedBox(height: 4.h),
          Text(
            'Search for dresses, accessories, jewelry, or brands',
            style: TextStyles.font12Regular(context).copyWith(
              color: ColorManager.getTextMuted(context),
            ),
          ),
        ],
      ),
    );
  }
}
