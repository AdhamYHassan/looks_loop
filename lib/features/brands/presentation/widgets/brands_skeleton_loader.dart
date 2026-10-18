import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/loaders/look_loops_skeleton.dart';

class BrandsSkeletonLoader extends StatelessWidget {
  const BrandsSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LookLoopsSkeleton(
                  height: 28.h,
                  width: 120.w,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                Gap(12.h),
                LookLoopsSkeleton(
                  height: 44.h,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                Gap(20.h),
                LookLoopsSkeleton(
                  height: 12.h,
                  width: 110.w,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ],
            ),
          ),
          Gap(10.h),
          SizedBox(
            height: 136.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, _) => Gap(10.w),
              itemBuilder: (_, _) => const _FeaturedBrandSkeletonCard(),
            ),
          ),
          Gap(20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: LookLoopsSkeleton(
              height: 12.h,
              width: 80.w,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
          Gap(10.h),
          for (int i = 0; i < 5; i++) const _AzBrandRowSkeleton(),
        ],
      ),
    );
  }
}

class _FeaturedBrandSkeletonCard extends StatelessWidget {
  const _FeaturedBrandSkeletonCard();

  @override
  Widget build(BuildContext context) {
    final surfaceColor = ColorManager.getSurface(context);
    final borderColor = ColorManager.getBorder(context);

    return Container(
      width: 130.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LookLoopsSkeleton(
            height: 48.w,
            width: 48.w,
            borderRadius: BorderRadius.circular(24.r),
          ),
          Gap(10.h),
          LookLoopsSkeleton(
            height: 12.h,
            width: 75.w,
            borderRadius: BorderRadius.circular(3.r),
          ),
          Gap(6.h),
          LookLoopsSkeleton(
            height: 10.h,
            width: 50.w,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ],
      ),
    );
  }
}

class _AzBrandRowSkeleton extends StatelessWidget {
  const _AzBrandRowSkeleton();

  @override
  Widget build(BuildContext context) {
    final borderColor = ColorManager.getBorder(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Row(
        children: [
          LookLoopsSkeleton(
            height: 42.w,
            width: 42.w,
            borderRadius: BorderRadius.circular(21.r),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LookLoopsSkeleton(
                  height: 14.h,
                  width: 100.w,
                  borderRadius: BorderRadius.circular(3.r),
                ),
                Gap(6.h),
                LookLoopsSkeleton(
                  height: 11.h,
                  width: 160.w,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ],
            ),
          ),
          Gap(10.w),
          LookLoopsSkeleton(
            height: 12.h,
            width: 20.w,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ],
      ),
    );
  }
}
