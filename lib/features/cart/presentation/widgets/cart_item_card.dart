import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/helpers/app_formatters.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:looks_loop/features/cart/presentation/widgets/cart_quantity_stepper.dart';

class CartItemCard extends StatelessWidget {
  final CartItemEntity item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        item.originalPrice != null && item.originalPrice! > item.price;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.getSurface(context),
        border: Border(
          bottom: BorderSide(
            color: ColorManager.getBorder(context),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: SizedBox(
              width: 82.w,
              height: 104.h,
              child: AppCachedImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.brand.toUpperCase(),
                  style: TextStyles.font11Eyebrow(context).copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(4.h),
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font14Medium(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(4.h),
                Text(
                  item.variantDescription,
                  style: TextStyles.font12Regular(context).copyWith(
                    color: ColorManager.getTextMuted(context),
                  ),
                ),
                Gap(12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CartQuantityStepper(
                      quantity: item.quantity,
                      onQuantityChanged: onQuantityChanged,
                      onRemove: onRemove,
                    ),
                    Row(
                      children: [
                        Text(
                          '${AppFormatters.amount(item.price)} EGP',
                          style: TextStyles.font13TextBold(context),
                        ),
                        if (hasDiscount) ...[
                          Gap(6.w),
                          Text(
                            '${AppFormatters.amount(item.originalPrice!)} EGP',
                            style: TextStyles.font11MutedLineThrough(context),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                Gap(8.h),
                GestureDetector(
                  onTap: onRemove,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    'REMOVE',
                    style: TextStyles.font11Action(context).copyWith(
                      fontSize: 10.sp,
                      letterSpacing: 1.0,
                      color: ColorManager.getTextMuted(context),
                      decoration: TextDecoration.underline,
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
