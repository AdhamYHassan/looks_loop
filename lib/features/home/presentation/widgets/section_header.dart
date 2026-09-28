import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String actionLabel;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.actionLabel = 'VIEW ALL',
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = ColorManager.getText(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(eyebrow, style: TextStyles.font11Eyebrow(context)),
                SizedBox(height: 3.h),
                Text(title, style: TextStyles.font20Bold(context)),
              ],
            ),
          ),
          InkWell(
            onTap: onActionTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(actionLabel, style: TextStyles.font11Action(context)),
                SizedBox(width: 4.w),
                Icon(LucideIcons.chevronRight, size: 16.sp, color: textColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
