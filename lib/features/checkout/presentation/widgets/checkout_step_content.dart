import 'package:flutter/material.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/checkout_step.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_cubit.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_state.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_address_step.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_delivery_step.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_payment_step.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_review_step.dart';

class CheckoutStepContent extends StatelessWidget {
  final CheckoutState state;
  final CheckoutCubit cubit;
  final AddressEntity? selectedAddress;
  final CartEntity? cart;

  const CheckoutStepContent({
    super.key,
    required this.state,
    required this.cubit,
    required this.selectedAddress,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return switch (state.currentStep) {
      CheckoutStep.address => CheckoutAddressStep(
          selectedAddressId: state.selectedAddressId,
          onSelectAddress: (addrId, provId) =>
              cubit.selectAddress(addrId, provinceId: provId),
        ),
      CheckoutStep.delivery => CheckoutDeliveryStep(
          methods: state.deliveryMethods,
          selectedMethod: state.selectedDeliveryMethod,
          isLoading: state.isLoadingDeliveryMethods,
          error: state.deliveryMethodsError,
          onSelectMethod: cubit.selectDeliveryMethod,
          onRetry: () {
            final pId = state.selectedProvinceId ??
                selectedAddress?.provinceId ??
                (selectedAddress != null && selectedAddress!.cityId > 0
                    ? selectedAddress!.cityId
                    : null);
            if (pId != null) cubit.loadDeliveryMethods(pId);
          },
        ),
      CheckoutStep.payment => CheckoutPaymentStep(
          methods: state.paymentMethods,
          selectedMethod: state.selectedPaymentMethod,
          isLoading: state.isLoadingPaymentMethods,
          error: state.paymentMethodsError,
          onSelectMethod: cubit.selectPaymentMethod,
          onRetry: cubit.loadPaymentMethods,
        ),
      CheckoutStep.review => CheckoutReviewStep(
          address: selectedAddress,
          deliveryMethod: state.selectedDeliveryMethod,
          paymentMethod: state.selectedPaymentMethod,
          cart: cart,
          onEditAddress: () => cubit.goToStep(CheckoutStep.address),
          onEditDelivery: () => cubit.goToStep(CheckoutStep.delivery),
          onEditPayment: () => cubit.goToStep(CheckoutStep.payment),
        ),
    };
  }
}
