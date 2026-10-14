import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ProductFilterSpecialOffers extends StatelessWidget {
  final bool sale;
  final bool newIn;
  final ValueChanged<bool> onSaleChanged;
  final ValueChanged<bool> onNewInChanged;

  const ProductFilterSpecialOffers({
    super.key,
    required this.sale,
    required this.newIn,
    required this.onSaleChanged,
    required this.onNewInChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SPECIAL OFFERS',
          style: TextStyles.font11Eyebrow(context).copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('On Sale Only', style: TextStyle(fontSize: 13.sp)),
          value: sale,
          activeColor: ColorManager.ink,
          onChanged: (val) => onSaleChanged(val ?? false),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('New In Only', style: TextStyle(fontSize: 13.sp)),
          value: newIn,
          activeColor: ColorManager.ink,
          onChanged: (val) => onNewInChanged(val ?? false),
        ),
      ],
    );
  }
}
