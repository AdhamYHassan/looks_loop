import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/loaders/look_loops_skeleton.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_header.dart';

class WishlistSkeletonLoader extends StatelessWidget {
  const WishlistSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RepaintBoundary(child: WishlistHeader()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                for (int i = 0; i < 4; i++) ...[
                  if (i > 0) Gap(16.h),
                  const _WishlistItemSkeletonCard(),
                ],
              ],
            ),
          ),
          Gap(40.h),
        ],
      ),
    );
  }
}

class _WishlistItemSkeletonCard extends StatelessWidget {
  const _WishlistItemSkeletonCard();

  @override
  Widget build(BuildContext context) {
    final surfaceColor = ColorManager.getSurface(context);
    final borderColor = ColorManager.getBorder(context);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor, width: 0.5.w),
      ),
      child: Row(
        children: [
          LookLoopsSkeleton(
            height: 102.h,
            width: 80.w,
            borderRadius: BorderRadius.circular(4.r),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LookLoopsSkeleton(
                  height: 12.h,
                  width: 72.w,
                  borderRadius: BorderRadius.circular(3.r),
                ),
                Gap(8.h),
                LookLoopsSkeleton(
                  height: 14.h,
                  width: 140.w,
                  borderRadius: BorderRadius.circular(3.r),
                ),
                Gap(10.h),
                LookLoopsSkeleton(
                  height: 14.h,
                  width: 85.w,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: LookLoopsSkeleton(
              height: 20.sp,
              width: 20.sp,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ],
      ),
    );
  }
}
