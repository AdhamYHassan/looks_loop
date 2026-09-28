import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ShopHubHeader extends StatelessWidget {
  const ShopHubHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SHOP',
            style: TextStyles.font32SemiBold(context),
          ),
          Gap(4.h),
          Text(
            'Who are you shopping for?',
            style: TextStyles.font13MutedMedium(context),
          ),
        ],
      ),
    );
  }
}
