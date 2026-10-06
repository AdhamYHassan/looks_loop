import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Card displayed when user is authenticated, showing avatar, name,
/// phone number and a View Account action.
class MoreUserCard extends StatelessWidget {
  final String name;
  final String? phone;
  final VoidCallback? onViewAccountTap;

  const MoreUserCard({
    super.key,
    required this.name,
    this.phone,
    this.onViewAccountTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = ColorManager.getCard(context);
    final borderColor = ColorManager.getBorder(context);
    final textColor = ColorManager.getText(context);
    final mutedColor = ColorManager.getTextMuted(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: ColorManager.getBackground(context),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(LucideIcons.userRound, size: 22.sp, color: textColor),
            ),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyles.font13TextBold(context).copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (phone != null && phone!.isNotEmpty) ...[
                  Gap(3.h),
                  Text(
                    phone!,
                    style: TextStyles.font13MutedMedium(context).copyWith(
                      fontSize: 12.sp,
                      color: mutedColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Gap(10.w),
          OutlinedButton(
            onPressed: onViewAccountTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorManager.olive,
              side: BorderSide(
                color: ColorManager.getBorder(context),
                width: 1.w,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            ),
            child: Text(
              'more.view_account'.tr(),
              style: TextStyle(
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: ColorManager.getText(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
