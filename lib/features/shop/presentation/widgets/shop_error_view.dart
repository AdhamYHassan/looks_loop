import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ShopErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ShopErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: TextStyles.font13TextBold(context).copyWith(
              color: Colors.red,
              fontSize: 14.sp,
            ),
          ),
          Gap(12.h),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
