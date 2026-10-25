import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_address_section.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_cancel_button.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_detail_header.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_info_card.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_items_section.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_summary_section.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_tracking_stepper.dart';

class OrderDetailContent extends StatelessWidget {
  final OrderDetailEntity order;
  final bool isCancelling;
  final VoidCallback onCancelTap;

  const OrderDetailContent({
    super.key,
    required this.order,
    this.isCancelling = false,
    required this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailHeader(order: order),
          Gap(16.h),
          OrderTrackingStepper(order: order),
          Gap(16.h),
          OrderItemsSection(items: order.items),
          Gap(16.h),
          OrderAddressSection(address: order.address),
          Gap(16.h),
          OrderInfoCard(
            title: 'orders.delivery_method'.tr(),
            primaryText: 'orders.standard_delivery'.tr(),
            secondaryText: 'orders.delivery_days'.tr(),
          ),
          Gap(16.h),
          OrderInfoCard(
            title: 'orders.payment_method'.tr(),
            primaryText: order.paymentMethodDisplay,
          ),
          Gap(16.h),
          OrderSummarySection(pricing: order.pricing),
          if (order.canCancel) ...[
            Gap(20.h),
            OrderCancelButton(
              isLoading: isCancelling,
              onCancelTap: onCancelTap,
            ),
          ],
          Gap(32.h),
        ],
      ),
    );
  }
}
