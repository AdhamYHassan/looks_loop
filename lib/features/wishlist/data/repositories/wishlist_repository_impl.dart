import 'dart:async';
import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource _remoteDataSource;
  final StreamController<List<ProductEntity>> _wishlistStreamController =
      StreamController<List<ProductEntity>>.broadcast();

  List<ProductEntity> _cachedItems = [];

  WishlistRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<ProductEntity>> get wishlistStream =>
      _wishlistStreamController.stream;

  @override
  Future<ApiResult<List<ProductEntity>>> getWishlist() async {
    try {
      final items = await _remoteDataSource.getWishlist();
      _cachedItems = List<ProductEntity>.from(items);
      _wishlistStreamController.add(List<ProductEntity>.from(_cachedItems));
      return ApiSuccess(List<ProductEntity>.from(_cachedItems));
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<void>> addToWishlist(ProductEntity product) async {
    final originalItems = List<ProductEntity>.from(_cachedItems);

    if (!_cachedItems.any((item) => item.id == product.id)) {
      _cachedItems = [..._cachedItems, product];
      _wishlistStreamController.add(List<ProductEntity>.from(_cachedItems));
    }

    try {
      final parsedId = int.tryParse(product.id) ?? 0;
      await _remoteDataSource.addToWishlist(parsedId);
      return const ApiSuccess(null);
    } catch (e) {
      _cachedItems = originalItems;
      _wishlistStreamController.add(List<ProductEntity>.from(_cachedItems));
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<void>> removeFromWishlist(String productId) async {
    final originalItems = List<ProductEntity>.from(_cachedItems);

    _cachedItems =
        _cachedItems.where((item) => item.id.trim() != productId.trim()).toList();
    _wishlistStreamController.add(List<ProductEntity>.from(_cachedItems));

    try {
      final parsedId = int.tryParse(productId) ?? 0;
      await _remoteDataSource.removeFromWishlist(parsedId);
      return const ApiSuccess(null);
    } catch (e) {
      _cachedItems = originalItems;
      _wishlistStreamController.add(List<ProductEntity>.from(_cachedItems));
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
