import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/helpers/app_formatters.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/orders/domain/entities/order_summary_entity.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_images_stack.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_status_badge.dart';

class OrderCard extends StatelessWidget {
  final OrderSummaryEntity order;
  final VoidCallback? onTap;

  const OrderCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    final muted = ColorManager.getTextMuted(context);
    final date = order.createdAt == null
        ? ''
        : AppFormatters.shortDate(order.createdAt!, context.locale.languageCode);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorManager.getCard(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.getBorder(context)),
      ),
      child: InkWell(
        onTap: onTap ?? () => context.push(Routes.orderDetailPath(order.orderNumber)),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '#${order.orderNumber}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.font14SemiBold(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OrderStatusBadge(
                    status: order.status,
                    fallbackLabel: order.statusDisplay,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(date, style: TextStyles.font12Regular(context).copyWith(color: muted)),
              const SizedBox(height: 14),
              Row(
                children: [
                  OrderImagesStack(
                    images: order.images,
                    itemCount: order.itemCount,
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'orders.items_count'.tr(args: ['${order.itemCount}']),
                        style: TextStyles.font12Regular(context).copyWith(color: muted),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${AppFormatters.amount(order.total)} ${'orders.currency'.tr()}',
                        style: TextStyles.font14SemiBold(context),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
