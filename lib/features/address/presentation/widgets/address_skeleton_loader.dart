import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/loaders/look_loops_skeleton.dart';

class AddressSkeletonLoader extends StatelessWidget {
  final int itemCount;

  const AddressSkeletonLoader({
    super.key,
    this.itemCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => _buildSkeletonCard(context),
    );
  }

  Widget _buildSkeletonCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.getCard(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.getBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              LookLoopsSkeleton(
                height: 22.h,
                width: 64.w,
                borderRadius: BorderRadius.circular(8.r),
              ),
              SizedBox(width: 8.w),
              LookLoopsSkeleton(
                height: 16.h,
                width: 90.w,
                borderRadius: BorderRadius.circular(4.r),
              ),
              const Spacer(),
              LookLoopsSkeleton(
                height: 20.h,
                width: 58.w,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          LookLoopsSkeleton.line(
            height: 14.h,
            width: double.infinity,
            borderRadius: BorderRadius.circular(4.r),
          ),
          SizedBox(height: 8.h),
          LookLoopsSkeleton.line(
            height: 14.h,
            width: 200.w,
            borderRadius: BorderRadius.circular(4.r),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              LookLoopsSkeleton(
                height: 16.h,
                width: 16.w,
                borderRadius: BorderRadius.circular(8.r),
              ),
              SizedBox(width: 6.w),
              LookLoopsSkeleton(
                height: 12.h,
                width: 70.w,
                borderRadius: BorderRadius.circular(4.r),
              ),
              SizedBox(width: 16.w),
              LookLoopsSkeleton(
                height: 16.h,
                width: 16.w,
                borderRadius: BorderRadius.circular(8.r),
              ),
              SizedBox(width: 6.w),
              LookLoopsSkeleton(
                height: 12.h,
                width: 85.w,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
