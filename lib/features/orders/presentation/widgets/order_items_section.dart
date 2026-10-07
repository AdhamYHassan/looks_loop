import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/helpers/spacing.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/orders/domain/entities/order_item_entity.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_detail_item_tile.dart';

class OrderItemsSection extends StatelessWidget {
  final List<OrderItemEntity> items;

  const OrderItemsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.getCard(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.getBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'orders.items_section_title'.tr(args: [items.length.toString()]),
            style: TextStyles.font11SemiBold(context).copyWith(
              letterSpacing: 1.2,
              color: ColorManager.getTextMuted(context),
            ),
          ),
          vGap(12),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) =>
                Divider(color: ColorManager.getBorder(context), height: 1),
            itemBuilder: (_, index) => OrderDetailItemTile(item: items[index]),
          ),
        ],
      ),
    );
  }
}
