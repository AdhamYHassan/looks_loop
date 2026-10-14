import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class CartAnnouncementBar extends StatelessWidget {
  final String text;

  const CartAnnouncementBar({
    super.key,
    this.text = 'EASY RETURNS',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorManager.olive,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyles.font8Announcement.copyWith(
          fontSize: 9.sp,
          letterSpacing: 2.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
