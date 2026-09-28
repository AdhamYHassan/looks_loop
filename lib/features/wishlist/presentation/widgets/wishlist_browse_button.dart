import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class WishlistBrowseButton extends StatelessWidget {
  final VoidCallback? onTap;

  const WishlistBrowseButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textColor = ColorManager.getText(context);
    final borderColor = ColorManager.getBorder(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: borderColor, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.heart, size: 16.sp, color: textColor),
            Gap(8.w),
            Text(
              'BROWSE PRODUCTS',
              style: TextStyles.font11Action(context).copyWith(
                color: textColor,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
