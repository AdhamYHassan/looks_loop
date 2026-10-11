import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/widgets/loaders/look_loops_skeleton.dart';

class HomeFeedSkeletonLoader extends StatelessWidget {
  const HomeFeedSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSkeleton(),
          Gap(24.h),
          _buildCategoriesSkeleton(),
          Gap(24.h),
          _buildProductRailSkeleton(),
          Gap(24.h),
          _buildTrendingGridSkeleton(),
          Gap(24.h),
          _buildLookSkeleton(),
          Gap(100.h),
        ],
      ),
    );
  }

  Widget _buildHeroSkeleton() {
    return Stack(
      children: [
        LookLoopsSkeleton(
          height: 440.h,
          width: double.infinity,
          borderRadius: BorderRadius.zero,
        ),
        Positioned(
          left: 20.w,
          right: 20.w,
          bottom: 40.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LookLoopsSkeleton(height: 12.h, width: 110.w),
              Gap(8.h),
              LookLoopsSkeleton(height: 28.h, width: 220.w),
              Gap(8.h),
              LookLoopsSkeleton(height: 14.h, width: 170.w),
              Gap(16.h),
              LookLoopsSkeleton(
                height: 40.h,
                width: 140.w,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSkeleton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LookLoopsSkeleton(height: 14.h, width: 130.w),
          Gap(10.h),
          Row(
            children: List.generate(
              3,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: LookLoopsSkeleton(
                    height: 120.h,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRailSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: LookLoopsSkeleton(height: 14.h, width: 140.w),
        ),
        Gap(10.h),
        SizedBox(
          height: 275.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, _) => Gap(14.w),
            itemBuilder: (_, _) => SizedBox(
              width: 156.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LookLoopsSkeleton(
                    height: 200.h,
                    width: 156.w,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  Gap(8.h),
                  LookLoopsSkeleton(height: 10.h, width: 70.w),
                  Gap(4.h),
                  LookLoopsSkeleton(height: 12.h, width: 120.w),
                  Gap(4.h),
                  LookLoopsSkeleton(height: 12.h, width: 80.w),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingGridSkeleton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LookLoopsSkeleton(height: 14.h, width: 150.w),
          Gap(10.h),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (_, _) => LookLoopsSkeleton(
              height: 220.h,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLookSkeleton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: LookLoopsSkeleton(
        height: 380.h,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}
