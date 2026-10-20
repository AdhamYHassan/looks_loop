import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/styles.dart';

class HomeErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const HomeErrorView({
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
            textAlign: TextAlign.center,
            style: TextStyles.font13TextBold(context).copyWith(
              color: Colors.red,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: onRetry,
            child: Text('common.retry'.tr()),
          ),
        ],
      ),
    );
  }
}
