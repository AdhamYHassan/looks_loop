import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MorePlaceholderView extends StatelessWidget {
  const MorePlaceholderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.getBackground(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.layoutGrid,
              size: 64.sp,
              color: ColorManager.getTextMuted(context),
            ),
            SizedBox(height: 16.h),
            Text('MORE & SETTINGS', style: TextStyles.font11BlackCta),
            SizedBox(height: 8.h),
            Text(
              'Account and extra options coming soon',
              style: TextStyles.font13TextBold(context).copyWith(
                color: ColorManager.getTextMuted(context),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
