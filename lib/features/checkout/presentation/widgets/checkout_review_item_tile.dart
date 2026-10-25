import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_item_entity.dart';

class CheckoutReviewItemTile extends StatelessWidget {
  final CartItemEntity item;

  const CheckoutReviewItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: Container(
              width: 52.w,
              height: 68.h,
              color: ColorManager.getBorder(context),
              child: item.imageUrl.isNotEmpty
                  ? Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported_outlined,
                        size: 20,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.brand.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: ColorManager.getText(context),
                  ),
                ),
                Gap(2.h),
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font14Regular(context).copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(4.h),
                Text(
                  item.variantDescription.isNotEmpty
                      ? '${item.variantDescription} · Qty ${item.quantity}'
                      : 'Qty ${item.quantity}',
                  style: TextStyles.font13MutedMedium(context).copyWith(
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          Gap(8.w),
          Text(
            '${item.totalPrice.toStringAsFixed(0)} EGP',
            style: TextStyles.font14SemiBold(context).copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
