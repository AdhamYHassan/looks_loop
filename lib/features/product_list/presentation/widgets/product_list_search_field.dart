import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductListSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback onClose;
  final VoidCallback onClear;

  const ProductListSearchField({
    super.key,
    required this.controller,
    this.onSubmitted,
    required this.onClose,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            LucideIcons.arrowLeft,
            color: ColorManager.cream,
            size: 20.sp,
          ),
          onPressed: onClose,
        ),
        Expanded(
          child: TextField(
            controller: controller,
            autofocus: true,
            style: TextStyle(color: ColorManager.cream, fontSize: 13.sp),
            textInputAction: TextInputAction.search,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: TextStyle(
                color: ColorManager.cream.withValues(alpha: 0.5),
                fontSize: 13.sp,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          icon: Icon(LucideIcons.x, color: ColorManager.cream, size: 18.sp),
          onPressed: onClear,
        ),
      ],
    );
  }
}
