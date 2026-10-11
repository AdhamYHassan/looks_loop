import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class EditorialSection extends StatelessWidget {
  final EditorialEntity editorial;
  final VoidCallback? onCtaTap;

  const EditorialSection({
    super.key,
    required this.editorial,
    this.onCtaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.getSurface(context),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: ColorManager.getBorder(context)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220.h,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(
                    imageUrl: editorial.imageUrl,
                    fit: BoxFit.cover,
                    memCacheWidth: 700,
                    memCacheHeight: 450,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    editorial.eyebrow.toUpperCase(),
                    style: TextStyles.font11Eyebrow(context).copyWith(
                      color: ColorManager.olive,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    editorial.title,
                    style: TextStyles.font20Bold(context).copyWith(
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (editorial.highlight.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      editorial.highlight,
                      style: TextStyles.font12Regular(context).copyWith(
                        color: ColorManager.getTextMuted(context),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  SizedBox(height: 8.h),
                  Text(
                    editorial.copy,
                    style: TextStyles.font13Regular(context).copyWith(
                      color: ColorManager.getTextMuted(context),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: onCtaTap,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: ColorManager.getText(context),
                      ),
                      iconAlignment: IconAlignment.end,
                      icon: Icon(LucideIcons.arrowRight, size: 14.sp),
                      label: Text(
                        editorial.ctaLabel.toUpperCase(),
                        style: TextStyles.font11SemiBold(context).copyWith(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
