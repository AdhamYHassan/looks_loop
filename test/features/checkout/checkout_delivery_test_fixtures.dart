import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/city_entity.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/checkout/data/models/place_order_request_model.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/placed_order_entity.dart';
import 'package:looks_loop/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:looks_loop/features/checkout/domain/usecases/get_delivery_methods_usecase.dart';
import 'package:looks_loop/features/checkout/domain/usecases/get_payment_methods_usecase.dart';
import 'package:looks_loop/features/checkout/domain/usecases/place_order_usecase.dart';

const dummyCairoProvince = ProvinceEntity(
  id: 1,
  countryId: 1,
  name: 'Cairo',
  nameEn: 'Cairo',
  nameAr: 'Cairo',
  cities: [
    CityEntity(
      id: 1,
      provinceId: 1,
      name: 'Cairo',
      nameEn: 'Cairo',
      nameAr: 'Cairo',
    ),
  ],
);

const dummyStandardDelivery = DeliveryMethodEntity(
  code: 'standard',
  name: 'Standard Delivery',
  description: '3–5 Business Days',
  fee: 100.0,
  freeDeliveryThreshold: 2000.0,
  usesGovernorateRates: true,
  isDefault: true,
);

const dummyExpressDelivery = DeliveryMethodEntity(
  code: 'express',
  name: 'Express Delivery',
  description: 'Next Business Day',
  fee: 80.0,
  freeDeliveryThreshold: null,
  usesGovernorateRates: false,
  isDefault: false,
);

const dummyCodPaymentMethod = PaymentMethodEntity(
  value: 'cod',
  label: 'Cash on Delivery',
  description: 'Pay when your order arrives',
  icon: '',
  enabled: true,
  status: 'active',
);

const dummyCardPaymentMethod = PaymentMethodEntity(
  value: 'card',
  label: 'Online Payment',
  description: 'Pay by card',
  icon: '',
  enabled: false,
  status: 'coming_soon',
);

class FakeCheckoutRepository implements CheckoutRepository {
  final List<DeliveryMethodEntity> deliveryMethods;
  final List<PaymentMethodEntity> paymentMethods;
  final bool shouldFail;

  FakeCheckoutRepository({
    this.deliveryMethods = const [
      dummyStandardDelivery,
      dummyExpressDelivery,
    ],
    this.paymentMethods = const [
      dummyCodPaymentMethod,
      dummyCardPaymentMethod,
    ],
    this.shouldFail = false,
  });

  @override
  Future<ApiResult<List<DeliveryMethodEntity>>> getDeliveryMethods(
    int provinceId,
  ) async {
    if (shouldFail) {
      return const ApiFailure(
        NetworkFailure('Failed to fetch delivery methods'),
      );
    }
    return ApiSuccess(deliveryMethods);
  }

  @override
  Future<ApiResult<List<PaymentMethodEntity>>> getPaymentMethods() async {
    if (shouldFail) {
      return const ApiFailure(
        NetworkFailure('Failed to fetch payment methods'),
      );
    }
    return ApiSuccess(paymentMethods);
  }

  @override
  Future<ApiResult<PlacedOrderEntity>> placeOrder(
    PlaceOrderRequestModel request,
  ) async {
    if (shouldFail) {
      return const ApiFailure(
        NetworkFailure('Failed to place order'),
      );
    }
    return const ApiSuccess(
      PlacedOrderEntity(orderNumber: 'ORD-12345', message: 'Success'),
    );
  }
}

PlaceOrderUseCase createTestPlaceOrderUseCase({bool shouldFail = false}) {
  return PlaceOrderUseCase(
    FakeCheckoutRepository(shouldFail: shouldFail),
  );
}

GetDeliveryMethodsUseCase createTestGetDeliveryMethodsUseCase({
  List<DeliveryMethodEntity>? methods,
  bool shouldFail = false,
}) {
  return GetDeliveryMethodsUseCase(
    FakeCheckoutRepository(
      deliveryMethods: methods ??
          const [
            dummyStandardDelivery,
            dummyExpressDelivery,
          ],
      shouldFail: shouldFail,
    ),
  );
}

GetPaymentMethodsUseCase createTestGetPaymentMethodsUseCase({
  List<PaymentMethodEntity>? methods,
  bool shouldFail = false,
}) {
  return GetPaymentMethodsUseCase(
    FakeCheckoutRepository(
      paymentMethods: methods ??
          const [
            dummyCodPaymentMethod,
            dummyCardPaymentMethod,
          ],
      shouldFail: shouldFail,
    ),
  );
}
