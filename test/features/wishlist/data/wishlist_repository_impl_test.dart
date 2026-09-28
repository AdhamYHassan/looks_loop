import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:looks_loop/features/wishlist/data/repositories/wishlist_repository_impl.dart';

class FakeWishlistRemoteDataSource implements WishlistRemoteDataSource {
  final List<ProductEntity> Function() onGet;
  final List<ProductEntity> Function(String) onRemove;

  FakeWishlistRemoteDataSource({
    required this.onGet,
    required this.onRemove,
  });

  @override
  Future<List<ProductEntity>> getWishlist() async => onGet();

  @override
  Future<List<ProductEntity>> removeFromWishlist(String id) async =>
      onRemove(id);
}

void main() {
  const dummyProduct = ProductEntity(
    id: 'w1',
    brand: 'MANGO',
    name: 'Wide Leg Trousers',
    price: 1590,
    imageUrl: 'https://example.com/item.jpg',
    isWishlisted: true,
  );

  test('WishlistRepositoryImpl returns ApiSuccess when data source succeeds',
      () async {
    final dataSource = FakeWishlistRemoteDataSource(
      onGet: () => [dummyProduct],
      onRemove: (_) => [],
    );
    final repo = WishlistRepositoryImpl(dataSource);

    final result = await repo.getWishlist();

    expect(result, isA<ApiSuccess<List<ProductEntity>>>());
    expect((result as ApiSuccess<List<ProductEntity>>).data, [dummyProduct]);
  });

  test('WishlistRepositoryImpl catches error and returns ApiFailure', () async {
    final dataSource = FakeWishlistRemoteDataSource(
      onGet: () => throw Exception('Network timeout'),
      onRemove: (_) => [],
    );
    final repo = WishlistRepositoryImpl(dataSource);

    final result = await repo.getWishlist();

    expect(result, isA<ApiFailure<List<ProductEntity>>>());
    final failure = (result as ApiFailure<List<ProductEntity>>).failure;
    expect(failure, isA<ServerFailure>());
  });
}
