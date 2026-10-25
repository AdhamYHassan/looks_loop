import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SearchHeaderBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final VoidCallback onClose;

  const SearchHeaderBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      color: ColorManager.getBackground(context),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: ColorManager.getSurface(context),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: ColorManager.cream.withValues(alpha: 0.15),
                  width: 0.8.w,
                ),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
                onChanged: onChanged,
                style: TextStyles.font14Medium(context),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search products, brands, categories...',
                  hintStyle: TextStyles.font14Regular(context).copyWith(
                    color: ColorManager.getTextMuted(context),
                  ),
                  prefixIcon: Icon(
                    LucideIcons.search,
                    size: 18.sp,
                    color: ColorManager.getTextMuted(context),
                  ),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (context, value, _) {
                      if (value.text.isEmpty) return const SizedBox.shrink();
                      return IconButton(
                        icon: Icon(
                          LucideIcons.x,
                          size: 16.sp,
                          color: ColorManager.getTextMuted(context),
                        ),
                        onPressed: onClear,
                      );
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          TextButton(
            onPressed: onClose,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              minimumSize: Size(44.w, 44.h),
            ),
            child: Text(
              'Cancel',
              style: TextStyles.font14Medium(context).copyWith(
                color: ColorManager.olive,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
