import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class ShopQuickLinks extends StatelessWidget {
  final List<String> links;
  final String selectedLink;
  final ValueChanged<String>? onLinkSelected;

  const ShopQuickLinks({
    super.key,
    required this.links,
    required this.selectedLink,
    this.onLinkSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: SizedBox(
        height: 30.h,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          scrollDirection: Axis.horizontal,
          itemCount: links.length,
          separatorBuilder: (_, _) => Gap(8.w),
          itemBuilder: (context, index) {
            final link = links[index];
            final isSale = link == 'SALE';
            final isSelected = link == selectedLink;
            return _QuickLinkButton(
              label: link,
              isSale: isSale,
              isSelected: isSelected,
              onTap: () => onLinkSelected?.call(link),
            );
          },
        ),
      ),
    );
  }
}

class _QuickLinkButton extends StatelessWidget {
  final String label;
  final bool isSale;
  final bool isSelected;
  final VoidCallback? onTap;

  const _QuickLinkButton({
    required this.label,
    required this.isSale,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceColor = ColorManager.getSurface(context);
    final borderColor = ColorManager.getBorder(context);
    final textColor = ColorManager.getText(context);

    Color bgColor = surfaceColor;
    Color borderCol = borderColor;
    Color textCol = textColor;

    if (isSale) {
      // bgColor = ColorManager.orange.withValues(alpha: 0.12);
      borderCol = ColorManager.orange;
      textCol = ColorManager.orange;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderCol, width: 0.5.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          label,
          style: TextStyles.font11Action(
            context,
          ).copyWith(color: textCol, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
