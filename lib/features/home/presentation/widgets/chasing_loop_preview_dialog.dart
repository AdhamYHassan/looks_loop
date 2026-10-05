import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/loaders/loaders.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Modal dialog dedicated to previewing the brand's [ChasingLoopLoader] in isolation.
class ChasingLoopPreviewDialog extends StatelessWidget {
  const ChasingLoopPreviewDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => const ChasingLoopPreviewDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        decoration: BoxDecoration(
          color: ColorManager.ink,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: ColorManager.cream.withValues(alpha: 0.12),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.sparkles,
                      color: ColorManager.sage,
                      size: 18.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Brand Loop Loader',
                      style: TextStyles.font16WhiteBold.copyWith(
                        color: ColorManager.cream,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    LucideIcons.x,
                    color: ColorManager.cream.withValues(alpha: 0.6),
                    size: 18.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 28.w, minHeight: 28.h),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: ColorManager.cream.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ChasingLoopLoader(
                size: 72.w,
                color: ColorManager.sage,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              'Continuous SVG Path vector loop animation',
              style: TextStyles.font13White70Regular.copyWith(
                color: ColorManager.cream.withValues(alpha: 0.5),
                fontSize: 11.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
