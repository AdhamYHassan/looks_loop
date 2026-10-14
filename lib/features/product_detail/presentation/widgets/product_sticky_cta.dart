import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ProductStickyCta extends StatelessWidget {
  final double price;
  final String currency;
  final bool isAvailable;
  final bool isLoading;
  final VoidCallback onAddToBag;

  const ProductStickyCta({
    super.key,
    required this.price,
    this.currency = 'EGP',
    this.isAvailable = true,
    this.isLoading = false,
    required this.onAddToBag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: ColorManager.getSurface(context),
        border: Border(
          top: BorderSide(
            color: ColorManager.getBorder(context),
            width: 1.w,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 12.r,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PRICE',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: ColorManager.getTextMuted(context),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${_formatPrice(price)} $currency',
                  style: TextStyles.font14SemiBold(context).copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: ElevatedButton(
                onPressed: (isAvailable && !isLoading) ? onAddToBag : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.ink,
                  foregroundColor: ColorManager.cream,
                  disabledBackgroundColor:
                      ColorManager.getBorder(context).withValues(alpha: 0.5),
                  disabledForegroundColor: ColorManager.getTextMuted(context),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 18.w,
                        height: 18.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ColorManager.cream,
                        ),
                      )
                    : Text(
                        isAvailable ? 'ADD TO BAG' : 'OUT OF STOCK',
                        style: TextStyles.font11Action(context).copyWith(
                          letterSpacing: 1.5,
                          color: isAvailable
                              ? ColorManager.cream
                              : ColorManager.getTextMuted(context),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
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
