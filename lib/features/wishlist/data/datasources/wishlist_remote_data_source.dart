import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

abstract interface class WishlistRemoteDataSource {
  Future<List<ProductEntity>> getWishlist();
  Future<List<ProductEntity>> removeFromWishlist(String productId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final List<ProductEntity> _items = [
    const ProductEntity(
      id: 'w1',
      brand: 'MANGO',
      name: 'Wide Leg Trousers',
      price: 1590,
      originalPrice: 1890,
      discountPercent: 16,
      imageUrl:
          'https://images.pexels.com/photos/8558355/pexels-photo-8558355.jpeg?auto=compress&cs=tinysrgb&w=700',
      isWishlisted: true,
    ),
    const ProductEntity(
      id: 'w2',
      brand: 'Mara Studio',
      name: 'The Crescent Bag',
      price: 2450,
      imageUrl:
          'https://images.pexels.com/photos/22432991/pexels-photo-22432991.jpeg?auto=compress&cs=tinysrgb&w=700',
      isWishlisted: true,
    ),
    const ProductEntity(
      id: 'w3',
      brand: 'Nile Objects',
      name: 'Sculptural Mule',
      price: 2100,
      originalPrice: 2500,
      discountPercent: 16,
      imageUrl:
          'https://images.pexels.com/photos/26851193/pexels-photo-26851193.jpeg?auto=compress&cs=tinysrgb&w=700',
      isWishlisted: true,
    ),
  ];

  @override
  Future<List<ProductEntity>> getWishlist() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List<ProductEntity>.from(_items);
  }

  @override
  Future<List<ProductEntity>> removeFromWishlist(String productId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _items.removeWhere((item) => item.id == productId);
    return List<ProductEntity>.from(_items);
  }
}
