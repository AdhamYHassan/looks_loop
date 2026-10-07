import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;
  final String fallbackLabel;

  const OrderStatusBadge({
    super.key,
    required this.status,
    required this.fallbackLabel,
  });

  Color get _color => switch (status) {
    OrderStatus.pending => ColorManager.orange,
    OrderStatus.confirmed ||
    OrderStatus.processing ||
    OrderStatus.shipped => ColorManager.olive,
    OrderStatus.delivered => const Color(0xFF2E7D4F),
    OrderStatus.cancelled => const Color(0xFFC62828),
    OrderStatus.unknown => ColorManager.muted,
  };

  String get _label => status == OrderStatus.unknown
      ? fallbackLabel
      : 'orders.status.${status.name}'.tr();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            _label,
            style: TextStyles.font11SemiBold(context).copyWith(color: _color),
          ),
        ],
      ),
    );
  }
}
