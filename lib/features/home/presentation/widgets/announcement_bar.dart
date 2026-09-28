import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class AnnouncementBar extends StatelessWidget {
  final String text;

  const AnnouncementBar({
    super.key,
    this.text = 'DISCOVER LOCAL & INTERNATIONAL BRANDS',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: double.infinity,
      color: ColorManager.olive,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyles.font8Announcement,
      ),
    );
  }
}
