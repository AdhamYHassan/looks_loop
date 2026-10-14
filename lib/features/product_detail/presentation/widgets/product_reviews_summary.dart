import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/product_detail/domain/entities/rating_distribution_entity.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/rating_distribution_bars.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductReviewsSummary extends StatelessWidget {
  final double score;
  final int totalReviews;
  final List<RatingDistributionEntity> distributions;
  final VoidCallback? onWriteReview;

  const ProductReviewsSummary({
    super.key,
    required this.score,
    required this.totalReviews,
    required this.distributions,
    this.onWriteReview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CUSTOMER REVIEWS',
          style: TextStyles.font11Eyebrow(context).copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 14.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  score.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 42.sp,
                    fontWeight: FontWeight.w900,
                    color: ColorManager.getText(context),
                  ),
                ),
                Text(
                  ' / 5',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.getTextMuted(context),
                  ),
                ),
              ],
            ),
            SizedBox(width: 24.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (_) {
                    return Icon(
                      Icons.star,
                      size: 16.sp,
                      color: ColorManager.getText(context),
                    );
                  }),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$totalReviews REVIEWS',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: ColorManager.getTextMuted(context),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        RatingDistributionBars(distributions: distributions),
        SizedBox(height: 16.h),
        OutlinedButton.icon(
          onPressed: onWriteReview,
          icon: Icon(
            LucideIcons.pencil,
            size: 14.sp,
            color: ColorManager.getText(context),
          ),
          label: Text(
            'WRITE A REVIEW',
            style: TextStyles.font11Action(context).copyWith(
              letterSpacing: 1.5,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: ColorManager.getBorder(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            minimumSize: Size(double.infinity, 44.h),
          ),
        ),
      ],
    );
  }
}
