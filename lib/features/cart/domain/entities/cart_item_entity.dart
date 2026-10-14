import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String id;
  final String productId;
  final String slug;
  final String brand;
  final String name;
  final String variantDescription;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.productId,
    this.slug = '',
    required this.brand,
    required this.name,
    required this.variantDescription,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      id: id,
      productId: productId,
      slug: slug,
      brand: brand,
      name: name,
      variantDescription: variantDescription,
      imageUrl: imageUrl,
      price: price,
      originalPrice: originalPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        slug,
        brand,
        name,
        variantDescription,
        imageUrl,
        price,
        originalPrice,
        quantity,
      ];
}
