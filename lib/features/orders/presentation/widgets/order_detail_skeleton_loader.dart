import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/loaders/look_loops_skeleton.dart';

class OrderDetailSkeletonLoader extends StatelessWidget {
  const OrderDetailSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildCard(
            context,
            height: 100.h,
            children: [
              LookLoopsSkeleton(
                height: 20.h,
                width: 140.w,
                borderRadius: BorderRadius.circular(4.r),
              ),
              Gap(8.h),
              LookLoopsSkeleton(
                height: 14.h,
                width: 100.w,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ],
          ),
          Gap(16.h),
          _buildCard(
            context,
            height: 180.h,
            children: [
              LookLoopsSkeleton(
                height: 14.h,
                width: 120.w,
                borderRadius: BorderRadius.circular(4.r),
              ),
              Gap(16.h),
              for (int i = 0; i < 3; i++) ...[
                Row(
                  children: [
                    LookLoopsSkeleton(
                      height: 18.h,
                      width: 18.w,
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                    Gap(12.w),
                    LookLoopsSkeleton(
                      height: 14.h,
                      width: 110.w,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ],
                ),
                if (i < 2) Gap(16.h),
              ],
            ],
          ),
          Gap(16.h),
          _buildCard(
            context,
            height: 140.h,
            children: [
              LookLoopsSkeleton(
                height: 14.h,
                width: 90.w,
                borderRadius: BorderRadius.circular(4.r),
              ),
              Gap(14.h),
              Row(
                children: [
                  LookLoopsSkeleton(
                    height: 56.h,
                    width: 56.w,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  Gap(12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LookLoopsSkeleton(
                        height: 14.h,
                        width: 120.w,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      Gap(6.h),
                      LookLoopsSkeleton(
                        height: 12.h,
                        width: 80.w,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required double height,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.getCard(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.getBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
