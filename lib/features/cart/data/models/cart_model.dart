import 'package:looks_loop/features/cart/data/models/cart_item_model.dart';
import 'package:looks_loop/features/cart/data/models/cart_summary_model.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.items,
    super.appliedPromoCode,
    super.discountAmount = 0.0,
    required super.summary,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final rawItems = (json['lines'] ?? json['items']) as List<dynamic>? ?? [];
    final items = rawItems
        .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
        .toList();

    final rawSubtotal = json['subtotal'];
    final rawDiscount =
        json['voucher_discount'] ?? json['savings'] ?? json['discount'];
    final rawTotal = json['total'];
    final rawDelivery = json['delivery'];

    final subtotal = double.tryParse(rawSubtotal?.toString() ?? '') ??
        items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
    final discount = double.tryParse(rawDiscount?.toString() ?? '') ?? 0.0;
    final total = double.tryParse(rawTotal?.toString() ?? '') ??
        (subtotal - discount).clamp(0.0, double.infinity);

    String deliveryText = 'Calculated at checkout';
    if (rawDelivery != null) {
      final dVal = double.tryParse(rawDelivery.toString()) ?? 0.0;
      deliveryText = dVal == 0 ? 'Free' : '${dVal.toInt()} EGP';
    }

    final summary = json['summary'] != null
        ? CartSummaryModel.fromJson(json['summary'] as Map<String, dynamic>)
        : CartSummaryModel(
            subtotal: subtotal,
            discount: discount,
            deliveryText: deliveryText,
            total: total,
          );

    final rawVoucher = json['voucher'] ?? json['applied_promo_code'];
    final appliedCode = rawVoucher is Map<String, dynamic>
        ? (rawVoucher['code']?.toString() ?? '')
        : (rawVoucher?.toString() ?? '');

    return CartModel(
      items: items,
      appliedPromoCode: appliedCode.isNotEmpty ? appliedCode : null,
      discountAmount: discount,
      summary: summary,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items
          .map((e) => e is CartItemModel
              ? e.toJson()
              : CartItemModel(
                  id: e.id,
                  productId: e.productId,
                  slug: e.slug,
                  brand: e.brand,
                  name: e.name,
                  variantDescription: e.variantDescription,
                  imageUrl: e.imageUrl,
                  price: e.price,
                  originalPrice: e.originalPrice,
                  quantity: e.quantity,
                ).toJson())
          .toList(),
      'applied_promo_code': appliedPromoCode,
      'discount_amount': discountAmount,
      'summary': summary is CartSummaryModel
          ? (summary as CartSummaryModel).toJson()
          : CartSummaryModel(
              subtotal: summary.subtotal,
              discount: summary.discount,
              deliveryText: summary.deliveryText,
              total: summary.total,
              currency: summary.currency,
            ).toJson(),
    };
  }
}
