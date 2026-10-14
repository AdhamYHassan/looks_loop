import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WishlistSignedOutChip extends StatelessWidget {
  final String message;
  final AnimationController shakeController;

  const WishlistSignedOutChip({
    super.key,
    required this.message,
    required this.shakeController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeController,
      builder: (context, child) {
        final shake = math.sin(shakeController.value * math.pi * 4) * 6.0;
        return Transform.translate(
          offset: Offset(shake, 0),
          child: child,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7.w,
            height: 7.w,
            decoration: const BoxDecoration(
              color: Color(0xFFD0552F),
              shape: BoxShape.circle,
            ),
          ),
          Gap(7.w),
          Flexible(
            child: Text(
              message.isNotEmpty
                  ? message
                  : 'Authentication credentials were not provided.',
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7A8068),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
