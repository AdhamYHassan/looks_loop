import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SearchEmptyView extends StatelessWidget {
  final String query;

  const SearchEmptyView({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.olive.withValues(alpha: 0.08),
              ),
              child: Icon(
                LucideIcons.searchX,
                size: 40.sp,
                color: ColorManager.olive,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No matches found',
              style: TextStyles.font18SemiBold(context),
            ),
            SizedBox(height: 8.h),
            Text(
              'We couldn\'t find any results for "$query". Please check your spelling or try broader terms.',
              textAlign: TextAlign.center,
              style: TextStyles.font12Regular(context).copyWith(
                color: ColorManager.getTextMuted(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
