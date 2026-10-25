import 'package:dio/dio.dart';
import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:looks_loop/features/checkout/data/models/place_order_request_model.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/placed_order_entity.dart';
import 'package:looks_loop/features/checkout/domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource _remoteDataSource;

  const CheckoutRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<List<DeliveryMethodEntity>>> getDeliveryMethods(
      int provinceId) async {
    try {
      final models = await _remoteDataSource.getDeliveryMethods(provinceId);
      final entities = models.map((m) => m.toEntity()).toList();
      return ApiSuccess(entities);
    } on DioException catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<List<PaymentMethodEntity>>> getPaymentMethods() async {
    try {
      final models = await _remoteDataSource.getPaymentMethods();
      final entities = models.map((m) => m.toEntity()).toList();
      return ApiSuccess(entities);
    } on DioException catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<PlacedOrderEntity>> placeOrder(
      PlaceOrderRequestModel request) async {
    try {
      final model = await _remoteDataSource.placeOrder(request);
      return ApiSuccess(model.toEntity());
    } on DioException catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
