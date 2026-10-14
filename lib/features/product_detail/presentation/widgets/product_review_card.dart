import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_review_entity.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductReviewCard extends StatelessWidget {
  final ProductReviewEntity review;
  final bool isHelpful;
  final VoidCallback? onHelpfulTap;

  const ProductReviewCard({
    super.key,
    required this.review,
    this.isHelpful = false,
    this.onHelpfulTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorManager.getBorder(context),
            width: 1.w,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(5, (index) {
              final isFilled = index < review.rating;
              return Icon(
                isFilled ? Icons.star : Icons.star_border,
                size: 13.sp,
                color: ColorManager.getText(context),
              );
            }),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.authorName,
                style: TextStyles.font13TextBold(context),
              ),
              Text(
                review.dateText,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: ColorManager.getTextMuted(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            review.body,
            style: TextStyles.font13Regular(context).copyWith(
              height: 1.5,
              color: ColorManager.getText(context).withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'SIZE PURCHASED: ${review.sizePurchased}',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: ColorManager.getTextMuted(context),
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: onHelpfulTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.thumbsUp,
                  size: 12.sp,
                  color: isHelpful
                      ? ColorManager.olive
                      : ColorManager.getTextMuted(context),
                ),
                SizedBox(width: 6.w),
                Text(
                  'HELPFUL (${review.helpfulCount + (isHelpful ? 1 : 0)})',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: isHelpful
                        ? ColorManager.olive
                        : ColorManager.getTextMuted(context),
                  ),
                ),
              ],
            ),
          ),
          if (review.storeReply != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: ColorManager.getSurface(context),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOOKS LOOP RESPONSE',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      color: ColorManager.getTextMuted(context),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    review.storeReply!,
                    style: TextStyles.font13Regular(context).copyWith(
                      fontSize: 12.sp,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
