import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

import 'package:easy_localization/easy_localization.dart';

class AnnouncementBar extends StatelessWidget {
  final String? text;

  const AnnouncementBar({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = text ?? 'home.default_announcement'.tr();
    return Container(
      height: 32.h,
      width: double.infinity,
      color: ColorManager.olive,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.center,
      child: Text(
        displayText,
        textAlign: TextAlign.center,
        style: TextStyles.font8Announcement,
      ),
    );
  }
}
