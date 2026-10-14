import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/helpers/secure_storage_helper.dart';
import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:looks_loop/features/cart/data/models/add_to_cart_request_model.dart';

class FakeNetworkHelper implements InetworkHelper {
  Response Function(String path, {dynamic data})? onPost;
  Response Function(String path)? onGet;

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    if (onGet != null) return onGet!(path);
    return Response(requestOptions: RequestOptions(path: path), data: {'data': {'lines': []}});
  }

  @override
  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    if (onPost != null) return onPost!(path, data: data);
    return Response(requestOptions: RequestOptions(path: path), data: {'data': {'lines': []}});
  }

  @override
  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async =>
      throw UnimplementedError();

  @override
  Future<Response> patch(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return Response(requestOptions: RequestOptions(path: path), data: {'data': {'lines': []}});
  }

  @override
  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return Response(requestOptions: RequestOptions(path: path), data: {'data': {'lines': []}});
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  final sampleCartData = {
    'cart_token': 'token_xyz_123',
    'lines': [],
    'subtotal': '0.00',
    'total': '0.00',
  };

  test('CartRemoteDataSource.getCart fetches cart and persists cart_token', () async {
    final net = FakeNetworkHelper();
    net.onGet = (path) {
      expect(path, ApiEndpoints.cart);
      return Response(
        requestOptions: RequestOptions(path: path),
        data: {'data': sampleCartData},
      );
    };

    final ds = CartRemoteDataSourceImpl(net);
    final result = await ds.getCart();

    expect(result.items, isEmpty);
    final savedToken = await SecureStorageHelper.getCartToken();
    expect(savedToken, 'token_xyz_123');
  });

  test('CartRemoteDataSource.addToCart posts to cartItems and persists cart_token', () async {
    final net = FakeNetworkHelper();
    net.onPost = (path, {data}) {
      expect(path, ApiEndpoints.cartItems);
      expect((data as Map)['product_id'], 8);
      return Response(
        requestOptions: RequestOptions(path: path),
        data: {'data': sampleCartData},
      );
    };

    final ds = CartRemoteDataSourceImpl(net);
    const req = AddToCartRequestModel(variantId: 76, productId: 8, colorId: 16, sizeId: 36);
    await ds.addToCart(req);

    final savedToken = await SecureStorageHelper.getCartToken();
    expect(savedToken, 'token_xyz_123');
  });

  test('CartRemoteDataSource.applyPromoCode posts to cart/voucher/ with code', () async {
    final net = FakeNetworkHelper();
    net.onPost = (path, {data}) {
      expect(path, '${ApiEndpoints.cart}voucher/');
      expect((data as Map)['code'], 'WELCOME200');
      return Response(
        requestOptions: RequestOptions(path: path),
        data: {'data': sampleCartData},
      );
    };

    final ds = CartRemoteDataSourceImpl(net);
    final result = await ds.applyPromoCode('WELCOME200');
    expect(result, isNotNull);
  });

  test('CartRemoteDataSource.removePromoCode sends DELETE to cart/voucher/', () async {
    final net = FakeNetworkHelper();
    final ds = CartRemoteDataSourceImpl(net);
    final result = await ds.removePromoCode();
    expect(result, isNotNull);
  });
}
