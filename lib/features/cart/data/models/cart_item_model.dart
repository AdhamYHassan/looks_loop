import 'package:looks_loop/features/cart/domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.productId,
    super.slug,
    required super.brand,
    required super.name,
    required super.variantDescription,
    required super.imageUrl,
    required super.price,
    super.originalPrice,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>?;
    final variant = json['variant'] as Map<String, dynamic>?;

    final brandName = product?['brand'] is Map
        ? (product!['brand']['name'] as String? ?? '')
        : (product?['brand'] as String? ?? (json['brand'] as String? ?? ''));

    String variantDesc = json['variant_description'] as String? ??
        (json['variant_label'] as String? ?? '');
    if (variantDesc.isEmpty && variant != null) {
      final color = variant['color'] as Map<String, dynamic>?;
      final size = variant['size'] as Map<String, dynamic>?;
      final colorName = color?['name'] as String? ?? '';
      final sizeLabel = size?['label'] as String? ?? '';
      final parts = [colorName, sizeLabel].where((s) => s.isNotEmpty).toList();
      variantDesc = parts.join(' / ');
    }

    final rawPrice = json['unit_price'] ?? json['price'];
    final rawOriginal = json['original_unit_price'] ?? json['original_price'];

    return CartItemModel(
      id: json['id']?.toString() ?? '',
      productId: product?['id']?.toString() ??
          (json['product_id']?.toString() ?? ''),
      slug: product?['slug'] as String? ?? (json['slug'] as String? ?? ''),
      brand: brandName,
      name: product?['name'] as String? ?? (json['name'] as String? ?? ''),
      variantDescription: variantDesc,
      imageUrl: product?['image'] as String? ??
          (json['image_url'] as String? ?? (json['image'] as String? ?? '')),
      price: double.tryParse(rawPrice?.toString() ?? '') ?? 0.0,
      originalPrice:
          rawOriginal != null ? double.tryParse(rawOriginal.toString()) : null,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'slug': slug,
      'brand': brand,
      'name': name,
      'variant_description': variantDescription,
      'image_url': imageUrl,
      'price': price,
      'original_price': originalPrice,
      'quantity': quantity,
    };
  }
}
