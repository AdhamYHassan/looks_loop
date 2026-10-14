import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ProductInfoHeader extends StatelessWidget {
  final String brand;
  final String name;
  final double price;
  final double? originalPrice;
  final String currency;
  final bool isInStock;
  final String sku;

  const ProductInfoHeader({
    super.key,
    required this.brand,
    required this.name,
    required this.price,
    this.originalPrice,
    this.currency = 'EGP',
    this.isInStock = true,
    this.sku = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              brand.toUpperCase(),
              style: TextStyles.font11Eyebrow(context).copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                color: ColorManager.getTextMuted(context),
              ),
            ),
            if (sku.isNotEmpty)
              Text(
                'SKU: $sku',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.getTextMuted(context),
                  letterSpacing: 1.0,
                ),
              ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          name,
          style: TextStyles.font20Bold(context).copyWith(
            fontSize: 22.sp,
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              '${_formatPrice(price)} $currency',
              style: TextStyles.font18SemiBold(context).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            if (originalPrice != null) ...[
              SizedBox(width: 8.w),
              Text(
                '${_formatPrice(originalPrice!)} $currency',
                style: TextStyles.font11MutedLineThrough(context).copyWith(
                  fontSize: 13.sp,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Container(
              width: 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isInStock ? const Color(0xFF2E7D32) : Colors.red,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              isInStock ? 'IN STOCK' : 'OUT OF STOCK',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: isInStock
                    ? const Color(0xFF2E7D32)
                    : Colors.redAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatPrice(double value) {
    final intVal = value.toInt();
    final str = intVal.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}
