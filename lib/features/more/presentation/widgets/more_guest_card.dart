import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MoreGuestCard extends StatelessWidget {
  final VoidCallback? onSignInTap;

  const MoreGuestCard({
    super.key,
    this.onSignInTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = ColorManager.getCard(context);
    final borderColor = ColorManager.getBorder(context);
    final textColor = ColorManager.getText(context);
    final mutedColor = ColorManager.getTextMuted(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 1.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: ColorManager.getBackground(context),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                LucideIcons.userRound,
                size: 24.sp,
                color: textColor,
              ),
            ),
          ),
          Gap(12.h),
          Text(
            'more.login_create_account'.tr(),
            textAlign: TextAlign.center,
            style: TextStyles.font13TextBold(context).copyWith(
              fontSize: 14.sp,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          Gap(6.h),
          Text(
            'more.login_subtitle'.tr(),
            textAlign: TextAlign.center,
            style: TextStyles.font13MutedMedium(context).copyWith(
              fontSize: 12.sp,
              color: mutedColor,
              height: 1.3,
            ),
          ),
          Gap(16.h),
          SizedBox(
            width: double.infinity,
            height: 42.h,
            child: ElevatedButton(
              onPressed: onSignInTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.ink,
                foregroundColor: ColorManager.cream,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'more.sign_in'.tr(),
                style: TextStyles.font11BlackCta.copyWith(
                  color: ColorManager.cream,
                  letterSpacing: 1.5,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
