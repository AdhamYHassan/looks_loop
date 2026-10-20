import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/looks/domain/entities/look_entity.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LookCard extends StatelessWidget {
  final LookSummaryEntity look;
  final VoidCallback onShopTap;

  const LookCard({
    super.key,
    required this.look,
    required this.onShopTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.getSurface(context),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: ColorManager.getBorder(context)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppCachedImage(
                  imageUrl: look.image,
                  fit: BoxFit.cover,
                  memCacheWidth: 450,
                  memCacheHeight: 600,
                  maxDiskWidth: 700,
                ),
                if (look.isFeatured)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: ColorManager.olive,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: Text(
                        'FEATURED',
                        style: TextStyles.font8Announcement.copyWith(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  look.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font13TextBold(context).copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(4.h),
                Text(
                  look.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font13MutedMedium(context).copyWith(
                    fontSize: 11.sp,
                    height: 1.25,
                  ),
                ),
                Gap(10.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onShopTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.olive,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                    iconAlignment: IconAlignment.end,
                    icon: Icon(LucideIcons.arrowUpRight, size: 14.sp),
                    label: Text(
                      'SHOP THIS LOOK',
                      style: TextStyles.font11WhiteEyebrow.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
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
