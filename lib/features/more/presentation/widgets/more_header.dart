import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class MoreHeader extends StatelessWidget {
  final String greeting;

  const MoreHeader({
    super.key,
    required this.greeting,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting.toUpperCase(),
            style: TextStyles.font11Eyebrow(context).copyWith(
              fontSize: 10.sp,
              color: ColorManager.olive,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(4.h),
          Text(
            'more.title'.tr(),
            style: TextStyles.font32SemiBold(context).copyWith(
              color: ColorManager.getText(context),
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}
