import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';

class AppInfoContent extends StatelessWidget {
  final AppInfoEntity appInfo;

  const AppInfoContent({super.key, required this.appInfo});

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (appInfo.title.isNotEmpty) ...[
            Text(
              appInfo.title,
              style: TextStyles.font18SemiBold(context),
            ),
            Gap(12.h),
          ],
          if (appInfo.updated != null) ...[
            Text(
              '${appInfo.updated!.year}-${appInfo.updated!.month.toString().padLeft(2, '0')}-${appInfo.updated!.day.toString().padLeft(2, '0')}',
              style: TextStyles.font13MutedMedium(context),
            ),
            Gap(16.h),
          ],
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.cardDark : ColorManager.cardLight,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark
                    ? ColorManager.borderDark
                    : ColorManager.borderLight,
              ),
            ),
            child: Text(
              appInfo.content,
              style: TextStyles.font13Regular(context).copyWith(
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

