import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BrandsSearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final FocusNode? focusNode;

  const BrandsSearchHeader({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = ColorManager.getBorder(context);
    final surfaceColor = ColorManager.getSurface(context);
    final textColor = ColorManager.getText(context);
    final mutedColor = ColorManager.getTextMuted(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BRANDS',
            style: TextStyles.font26TextBlack(context).copyWith(
              letterSpacing: 1.5,
              fontWeight: FontWeight.w900,
            ),
          ),
          Gap(12.h),
          Container(
            height: 44.h,
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: borderColor),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Icon(
                  LucideIcons.search,
                  size: 16.sp,
                  color: mutedColor,
                ),
                Gap(10.w),
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onChanged: onChanged,
                    style: TextStyles.font14Regular(context).copyWith(
                      color: textColor,
                    ),
                    cursorColor: ColorManager.olive,
                    decoration: InputDecoration(
                      hintText: 'Search brands...',
                      hintStyle: TextStyles.font14Regular(context).copyWith(
                        color: mutedColor,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                if (controller.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      controller.clear();
                      onClear();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: Icon(
                        LucideIcons.x,
                        size: 16.sp,
                        color: mutedColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
