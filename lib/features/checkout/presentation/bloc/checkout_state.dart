import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/checkout/domain/entities/checkout_step.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/placed_order_entity.dart';

class CheckoutState extends Equatable {
  final CheckoutStep currentStep;
  final int? selectedAddressId;
  final int? selectedProvinceId;
  final List<DeliveryMethodEntity> deliveryMethods;
  final DeliveryMethodEntity? selectedDeliveryMethod;
  final bool isLoadingDeliveryMethods;
  final String? deliveryMethodsError;
  final List<PaymentMethodEntity> paymentMethods;
  final PaymentMethodEntity? selectedPaymentMethod;
  final bool isLoadingPaymentMethods;
  final String? paymentMethodsError;
  final bool isPlacingOrder;
  final String? orderError;
  final PlacedOrderEntity? placedOrder;

  const CheckoutState({
    this.currentStep = CheckoutStep.address,
    this.selectedAddressId,
    this.selectedProvinceId,
    this.deliveryMethods = const [],
    this.selectedDeliveryMethod,
    this.isLoadingDeliveryMethods = false,
    this.deliveryMethodsError,
    this.paymentMethods = const [],
    this.selectedPaymentMethod,
    this.isLoadingPaymentMethods = false,
    this.paymentMethodsError,
    this.isPlacingOrder = false,
    this.orderError,
    this.placedOrder,
  });

  CheckoutState copyWith({
    CheckoutStep? currentStep,
    int? Function()? selectedAddressId,
    int? Function()? selectedProvinceId,
    List<DeliveryMethodEntity>? deliveryMethods,
    DeliveryMethodEntity? Function()? selectedDeliveryMethod,
    bool? isLoadingDeliveryMethods,
    String? Function()? deliveryMethodsError,
    List<PaymentMethodEntity>? paymentMethods,
    PaymentMethodEntity? Function()? selectedPaymentMethod,
    bool? isLoadingPaymentMethods,
    String? Function()? paymentMethodsError,
    bool? isPlacingOrder,
    String? Function()? orderError,
    PlacedOrderEntity? Function()? placedOrder,
  }) {
    return CheckoutState(
      currentStep: currentStep ?? this.currentStep,
      selectedAddressId: selectedAddressId != null
          ? selectedAddressId()
          : this.selectedAddressId,
      selectedProvinceId: selectedProvinceId != null
          ? selectedProvinceId()
          : this.selectedProvinceId,
      deliveryMethods: deliveryMethods ?? this.deliveryMethods,
      selectedDeliveryMethod: selectedDeliveryMethod != null
          ? selectedDeliveryMethod()
          : this.selectedDeliveryMethod,
      isLoadingDeliveryMethods:
          isLoadingDeliveryMethods ?? this.isLoadingDeliveryMethods,
      deliveryMethodsError: deliveryMethodsError != null
          ? deliveryMethodsError()
          : this.deliveryMethodsError,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectedPaymentMethod: selectedPaymentMethod != null
          ? selectedPaymentMethod()
          : this.selectedPaymentMethod,
      isLoadingPaymentMethods:
          isLoadingPaymentMethods ?? this.isLoadingPaymentMethods,
      paymentMethodsError: paymentMethodsError != null
          ? paymentMethodsError()
          : this.paymentMethodsError,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      orderError: orderError != null ? orderError() : this.orderError,
      placedOrder: placedOrder != null ? placedOrder() : this.placedOrder,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        selectedAddressId,
        selectedProvinceId,
        deliveryMethods,
        selectedDeliveryMethod,
        isLoadingDeliveryMethods,
        deliveryMethodsError,
        paymentMethods,
        selectedPaymentMethod,
        isLoadingPaymentMethods,
        paymentMethodsError,
        isPlacingOrder,
        orderError,
        placedOrder,
      ];
}
