import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/checkout_step.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_cubit.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_state.dart';

class CheckoutStepHelper {
  const CheckoutStepHelper._();

  static bool isStepEnabled(CheckoutState s, bool hasAddr) => switch (s.currentStep) {
        CheckoutStep.address => s.selectedAddressId != null || hasAddr,
        CheckoutStep.delivery =>
          s.selectedDeliveryMethod != null && !s.isLoadingDeliveryMethods,
        CheckoutStep.payment =>
          s.selectedPaymentMethod?.isSelectable == true && !s.isLoadingPaymentMethods,
        CheckoutStep.review => !s.isPlacingOrder,
      };

  static String getCtaLabel(CheckoutStep step, {bool isPlacingOrder = false}) {
    if (isPlacingOrder && step == CheckoutStep.review) return 'PLACING ORDER...';
    return switch (step) {
      CheckoutStep.address => 'CONTINUE',
      CheckoutStep.delivery => 'CONTINUE TO PAYMENT',
      CheckoutStep.payment => 'CONTINUE',
      CheckoutStep.review => 'PLACE ORDER',
    };
  }

  static String? calculatePriceText(CheckoutState state, CartEntity? cart) {
    if (state.currentStep != CheckoutStep.review || cart == null) return null;
    final delivery = state.selectedDeliveryMethod?.calculateCost(cart.summary.subtotal) ?? 0.0;
    final total = cart.summary.subtotal - cart.summary.discount + delivery;
    return '${total.toStringAsFixed(0)} EGP';
  }

  static void handleCtaPress({
    required CheckoutCubit cubit,
    required CheckoutState state,
    required AddressEntity? address,
  }) {
    if (state.currentStep == CheckoutStep.review) {
      if (address != null) cubit.placeOrder(address);
      return;
    }
    if (state.currentStep == CheckoutStep.address) {
      final pId = address?.provinceId ??
          (address != null && address.cityId > 0 ? address.cityId : null);
      if (pId != null && state.deliveryMethods.isEmpty) {
        cubit.loadDeliveryMethods(pId);
      }
    } else if (state.currentStep == CheckoutStep.delivery &&
        state.paymentMethods.isEmpty) {
      cubit.loadPaymentMethods();
    }
    cubit.nextStep();
  }
}
