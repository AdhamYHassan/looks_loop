import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CartQuantityStepper extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const CartQuantityStepper({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.getBorder(context),
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: LucideIcons.minus,
            onTap: () {
              if (quantity > 1) {
                onQuantityChanged(quantity - 1);
              } else {
                onRemove();
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              '$quantity',
              style: TextStyles.font12Medium(context),
            ),
          ),
          _buildButton(
            icon: LucideIcons.plus,
            onTap: () => onQuantityChanged(quantity + 1),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Icon(icon, size: 14.sp),
      ),
    );
  }
}
