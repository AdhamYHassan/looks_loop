import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Single password requirement bullet with smooth indicator and state transitions.
class PasswordRequirementItem extends StatelessWidget {
  final String label;
  final bool isMet;

  const PasswordRequirementItem({
    super.key,
    required this.label,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = ColorManager.olive;
    final inactiveColor = ColorManager.getTextMuted(context).withValues(alpha: 0.6);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.only(top: 2.h),
            child: Icon(
              isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
              size: 14.sp,
              color: isMet ? activeColor : inactiveColor,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                color: isMet
                    ? ColorManager.backgroundDark
                    : ColorManager.getTextMuted(context),
                fontSize: 12.sp,
                fontWeight: isMet ? FontWeight.w600 : FontWeight.w400,
                height: 1.3,
                fontFamily: 'Cairo',
              ),
              child: Text(label),
            ),
          ),
        ],
      ),
    );
  }
}
