import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_item_tile.dart';

class MoreSectionCard extends StatelessWidget {
  final String title;
  final List<MoreItemTile> items;

  const MoreSectionCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = ColorManager.getCard(context);
    final borderColor = ColorManager.getBorder(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 8.h),
            child: Text(
              title.toUpperCase(),
              style: TextStyles.font11Eyebrow(context).copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: borderColor, width: 1.w),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1.h,
                      thickness: 1.h,
                      color: borderColor,
                    ),
                  items[i],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
