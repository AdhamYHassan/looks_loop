import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/domain/entities/order_item_entity.dart';

class OrderItemModel extends Equatable {
  final int id;
  final int productId;
  final String productSlug;
  final String name;
  final String brandName;
  final String variant;
  final String image;
  final double unitPrice;
  final int quantity;
  final double lineTotal;

  const OrderItemModel({
    required this.id,
    required this.productId,
    required this.productSlug,
    required this.name,
    required this.brandName,
    required this.variant,
    required this.image,
    required this.unitPrice,
    required this.quantity,
    required this.lineTotal,
  });

  factory OrderItemModel.fromJson(
    Map<String, dynamic> json, {
    String fallbackBrand = '',
  }) {
    final rawUnitPrice = json['unit_price'];
    final unitPrice = rawUnitPrice is num
        ? rawUnitPrice.toDouble()
        : double.tryParse(rawUnitPrice?.toString() ?? '') ?? 0.0;

    final rawLineTotal = json['line_total'];
    final lineTotal = rawLineTotal is num
        ? rawLineTotal.toDouble()
        : double.tryParse(rawLineTotal?.toString() ?? '') ?? 0.0;

    final rawBrandName = json['brand_name'] as String?;
    final brandName = (rawBrandName != null && rawBrandName.isNotEmpty)
        ? rawBrandName
        : fallbackBrand;

    return OrderItemModel(
      id: json['id'] as int? ?? 0,
      productId: json['product_id'] as int? ?? 0,
      productSlug: json['product_slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      brandName: brandName,
      variant: json['variant'] as String? ?? '',
      image: json['image'] as String? ?? '',
      unitPrice: unitPrice,
      quantity: json['quantity'] as int? ?? 1,
      lineTotal: lineTotal,
    );
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      id: id,
      productId: productId,
      productSlug: productSlug,
      name: name,
      brandName: brandName,
      variant: variant,
      image: image,
      unitPrice: unitPrice,
      quantity: quantity,
      lineTotal: lineTotal,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productSlug,
        name,
        brandName,
        variant,
        image,
        unitPrice,
        quantity,
        lineTotal,
      ];
}
