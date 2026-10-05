import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MoreItemTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const MoreItemTile({
    super.key,
    required this.icon,
    required this.label,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = ColorManager.getText(context);
    final mutedColor = ColorManager.getTextMuted(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: textColor,
            ),
            Gap(14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyles.font13TextBold(context).copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    Gap(2.h),
                    Text(
                      subtitle!,
                      style: TextStyles.font13MutedMedium(context).copyWith(
                        fontSize: 11.sp,
                        color: mutedColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                Icon(
                  LucideIcons.chevronRight,
                  size: 18.sp,
                  color: mutedColor,
                ),
          ],
        ),
      ),
    );
  }
}
