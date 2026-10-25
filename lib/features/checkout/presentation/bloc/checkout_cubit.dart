import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/checkout/data/models/place_order_request_model.dart';
import 'package:looks_loop/features/checkout/domain/entities/checkout_step.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/placed_order_entity.dart';
import 'package:looks_loop/features/checkout/domain/usecases/get_delivery_methods_usecase.dart';
import 'package:looks_loop/features/checkout/domain/usecases/get_payment_methods_usecase.dart';
import 'package:looks_loop/features/checkout/domain/usecases/place_order_usecase.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final GetDeliveryMethodsUseCase _getDeliveryMethodsUseCase;
  final GetPaymentMethodsUseCase _getPaymentMethodsUseCase;
  final PlaceOrderUseCase _placeOrderUseCase;

  CheckoutCubit(
    this._getDeliveryMethodsUseCase,
    this._getPaymentMethodsUseCase,
    this._placeOrderUseCase,
  ) : super(const CheckoutState());

  void selectAddress(int addressId, {int? provinceId}) {
    emit(state.copyWith(
      selectedAddressId: () => addressId,
      selectedProvinceId: () => provinceId,
    ));
    if (provinceId != null) loadDeliveryMethods(provinceId);
  }

  Future<void> loadDeliveryMethods(int provinceId) async {
    emit(state.copyWith(
      isLoadingDeliveryMethods: true,
      deliveryMethodsError: () => null,
      selectedProvinceId: () => provinceId,
    ));

    final result = await _getDeliveryMethodsUseCase(provinceId);
    switch (result) {
      case ApiSuccess<List<DeliveryMethodEntity>>(:final data):
        final defaultMethod = data.cast<DeliveryMethodEntity?>().firstWhere(
              (m) => m?.isDefault == true,
              orElse: () => data.firstOrNull,
            );
        emit(state.copyWith(
          isLoadingDeliveryMethods: false,
          deliveryMethods: data,
          selectedDeliveryMethod: () => defaultMethod,
        ));
      case ApiFailure(:final failure):
        emit(state.copyWith(
          isLoadingDeliveryMethods: false,
          deliveryMethodsError: () => failure.message,
        ));
    }
  }

  Future<void> loadPaymentMethods() async {
    emit(state.copyWith(
      isLoadingPaymentMethods: true,
      paymentMethodsError: () => null,
    ));

    final result = await _getPaymentMethodsUseCase();
    switch (result) {
      case ApiSuccess<List<PaymentMethodEntity>>(:final data):
        final activeDefault = data.cast<PaymentMethodEntity?>().firstWhere(
              (m) => m != null && m.isSelectable,
              orElse: () => null,
            );
        emit(state.copyWith(
          isLoadingPaymentMethods: false,
          paymentMethods: data,
          selectedPaymentMethod: () => activeDefault,
        ));
      case ApiFailure(:final failure):
        emit(state.copyWith(
          isLoadingPaymentMethods: false,
          paymentMethodsError: () => failure.message,
        ));
    }
  }

  Future<void> placeOrder(
    AddressEntity address, {
    String note = '',
    String email = '',
  }) async {
    final delivery = state.selectedDeliveryMethod?.code;
    final payment = state.selectedPaymentMethod?.value;
    if (delivery == null || payment == null) return;

    emit(state.copyWith(isPlacingOrder: true, orderError: () => null));

    final request = PlaceOrderRequestModel(
      addressId: address.id,
      deliveryMethod: delivery,
      paymentMethod: payment,
      note: note,
      fullName: address.fullName,
      phone: address.phone,
      email: email,
    );

    final result = await _placeOrderUseCase(request);
    switch (result) {
      case ApiSuccess<PlacedOrderEntity>(:final data):
        emit(state.copyWith(isPlacingOrder: false, placedOrder: () => data));
      case ApiFailure(:final failure):
        emit(state.copyWith(
          isPlacingOrder: false,
          orderError: () => failure.message,
        ));
    }
  }

  void selectDeliveryMethod(DeliveryMethodEntity method) {
    emit(state.copyWith(selectedDeliveryMethod: () => method));
  }

  void selectPaymentMethod(PaymentMethodEntity method) {
    if (!method.isSelectable) return;
    emit(state.copyWith(selectedPaymentMethod: () => method));
  }

  void goToStep(CheckoutStep step) => emit(state.copyWith(currentStep: step));

  bool nextStep() {
    final nextIndex = state.currentStep.index + 1;
    if (nextIndex < CheckoutStep.values.length) {
      emit(state.copyWith(currentStep: CheckoutStep.values[nextIndex]));
      return true;
    }
    return false;
  }

  bool previousStep() {
    final prevIndex = state.currentStep.index - 1;
    if (prevIndex >= 0) {
      emit(state.copyWith(currentStep: CheckoutStep.values[prevIndex]));
      return true;
    }
    return false;
  }
}
