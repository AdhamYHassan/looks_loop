import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CartSubNavBar extends StatelessWidget {
  final int itemCount;
  final VoidCallback onBack;
  final VoidCallback? onSearch;

  const CartSubNavBar({
    super.key,
    required this.itemCount,
    required this.onBack,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final countLabel = itemCount == 1 ? '1 ITEM' : '$itemCount ITEMS';

    return Container(
      decoration: BoxDecoration(
        color: ColorManager.getSurface(context),
        border: Border(
          bottom: BorderSide(
            color: ColorManager.getBorder(context),
            width: 1.w,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              LucideIcons.arrowLeft,
              color: ColorManager.getText(context),
              size: 20.sp,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: onBack,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Row(
              children: [
                Text(
                  'SHOPPING BAG',
                  style: TextStyles.font12Brand(context).copyWith(
                    fontSize: 14.sp,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: ColorManager.getBorder(context),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    countLabel,
                    style: TextStyles.font11Eyebrow(context).copyWith(
                      fontSize: 9.sp,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              LucideIcons.search,
              color: ColorManager.getText(context),
              size: 18.sp,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }
}
