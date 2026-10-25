import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_review_address_section.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_review_delivery_section.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_review_item_tile.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_review_payment_section.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_review_price_summary.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_section_header.dart';

class CheckoutReviewStep extends StatelessWidget {
  final AddressEntity? address;
  final DeliveryMethodEntity? deliveryMethod;
  final PaymentMethodEntity? paymentMethod;
  final CartEntity? cart;
  final VoidCallback onEditAddress;
  final VoidCallback onEditDelivery;
  final VoidCallback onEditPayment;

  const CheckoutReviewStep({
    super.key,
    required this.address,
    required this.deliveryMethod,
    required this.paymentMethod,
    required this.cart,
    required this.onEditAddress,
    required this.onEditDelivery,
    required this.onEditPayment,
  });

  @override
  Widget build(BuildContext context) {
    final items = cart?.items ?? const <CartItemEntity>[];
    final subtotal = cart?.summary.subtotal ?? 0.0;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REVIEW YOUR ORDER',
            style: TextStyles.font20Bold(context).copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          Gap(16.h),
          CheckoutReviewAddressSection(
            address: address,
            onEdit: onEditAddress,
          ),
          _buildDivider(),
          CheckoutReviewDeliverySection(
            deliveryMethod: deliveryMethod,
            subtotal: subtotal,
            onEdit: onEditDelivery,
          ),
          _buildDivider(),
          CheckoutReviewPaymentSection(
            paymentMethod: paymentMethod,
            onEdit: onEditPayment,
          ),
          _buildDivider(),
          _buildItemsSection(context, items),
          _buildDivider(),
          if (cart != null)
            CheckoutReviewPriceSummary(
              summary: cart!.summary,
              deliveryMethod: deliveryMethod,
            ),
          Gap(120.h),
        ],
      ),
    );
  }

  Widget _buildDivider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: const Divider(height: 1, color: ColorManager.line),
      );

  Widget _buildItemsSection(BuildContext context, List<CartItemEntity> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckoutSectionHeader(
          title: 'ITEMS (${items.length})',
        ),
        if (items.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              'No items in your bag',
              style: TextStyles.font13MutedMedium(context),
            ),
          )
        else
          ...items.map((item) => CheckoutReviewItemTile(item: item)),
      ],
    );
  }
}
