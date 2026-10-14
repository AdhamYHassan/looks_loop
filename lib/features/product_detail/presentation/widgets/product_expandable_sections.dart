import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductExpandableSections extends StatelessWidget {
  final List<String> details;
  final String materialAndCare;
  final String sizeAndFit;
  final String deliveryAndReturns;
  final int? expandedIndex;
  final ValueChanged<int> onToggle;

  const ProductExpandableSections({
    super.key,
    this.details = const [],
    this.materialAndCare = '',
    this.sizeAndFit = '',
    this.deliveryAndReturns = '',
    required this.expandedIndex,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final sections = [
      if (details.isNotEmpty) ('PRODUCT DETAILS', _buildDetailsContent(context)),
      if (materialAndCare.trim().isNotEmpty)
        ('MATERIAL & CARE', _buildTextContent(context, materialAndCare)),
      if (sizeAndFit.trim().isNotEmpty)
        ('SIZE & FIT', _buildTextContent(context, sizeAndFit)),
      if (deliveryAndReturns.trim().isNotEmpty)
        ('DELIVERY & RETURNS', _buildTextContent(context, deliveryAndReturns)),
    ];

    if (sections.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: List.generate(sections.length, (index) {
        final (title, content) = sections[index];
        final isExpanded = expandedIndex == index;

        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ColorManager.getBorder(context),
                width: 1.w,
              ),
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => onToggle(index),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyles.font11Action(
                          context,
                        ).copyWith(fontSize: 12.sp, letterSpacing: 1.5),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          LucideIcons.chevronDown,
                          size: 18.sp,
                          color: ColorManager.getText(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: content,
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailsContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: details.map((detail) {
        return Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: Row(
            children: [
              Container(
                width: 4.w,
                height: 4.h,
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                  color: ColorManager.getTextMuted(context),
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                detail,
                style: TextStyles.font13Regular(context).copyWith(height: 1.4),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextContent(BuildContext context, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyles.font13Regular(context).copyWith(
          height: 1.5,
          color: ColorManager.getText(context).withValues(alpha: 0.85),
        ),
      ),
    );
  }
}
