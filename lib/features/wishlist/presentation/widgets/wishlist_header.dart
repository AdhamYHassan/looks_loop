import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class WishlistHeader extends StatelessWidget {
  const WishlistHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = ColorManager.getText(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SAVED FOR LATER',
            style: TextStyles.font11Eyebrow(context).copyWith(
              fontSize: 10.sp,
              color: ColorManager.olive,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(4.h),
          Text(
            'Wishlist',
            style: TextStyles.font32SemiBold(context).copyWith(
              color: textColor,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}
