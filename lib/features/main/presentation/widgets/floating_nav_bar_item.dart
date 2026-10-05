import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingNavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isScrolled;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const FloatingNavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isScrolled,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 4.h,
            ),
            child: Icon(
              icon,
              size: 22.sp,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOutCubic,
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: isScrolled ? 0 : null,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                opacity: isScrolled ? 0.0 : 1.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive ? activeColor : inactiveColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
