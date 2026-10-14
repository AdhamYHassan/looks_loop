import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/product_detail/domain/entities/rating_distribution_entity.dart';

class RatingDistributionBars extends StatelessWidget {
  final List<RatingDistributionEntity> distributions;

  const RatingDistributionBars({
    super.key,
    required this.distributions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: distributions.map((dist) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Row(
            children: [
              SizedBox(
                width: 28.w,
                child: Text(
                  '${dist.star} ★',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.getTextMuted(context),
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.r),
                  child: Container(
                    height: 6.h,
                    color: ColorManager.getBorder(context),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: dist.percentage.clamp(0.0, 1.0),
                      child: Container(
                        color: ColorManager.getText(context),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                width: 24.w,
                child: Text(
                  '${dist.count}',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: ColorManager.getTextMuted(context),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
