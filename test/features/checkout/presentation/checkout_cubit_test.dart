import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/checkout/domain/entities/checkout_step.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_cubit.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_state.dart';
import '../checkout_delivery_test_fixtures.dart';
import '../checkout_test_fixtures.dart';

void main() {
  late CheckoutCubit cubit;

  setUp(() {
    cubit = CheckoutCubit(
      createTestGetDeliveryMethodsUseCase(),
      createTestGetPaymentMethodsUseCase(),
      createTestPlaceOrderUseCase(),
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('CheckoutCubit', () {
    test('initial state has address step and null selections', () {
      expect(
        cubit.state,
        const CheckoutState(
          currentStep: CheckoutStep.address,
          selectedAddressId: null,
          selectedProvinceId: null,
          deliveryMethods: [],
          selectedDeliveryMethod: null,
          paymentMethods: [],
          selectedPaymentMethod: null,
        ),
      );
    });

    test('selectAddress updates state and triggers delivery methods when provinceId provided',
        () async {
      cubit.selectAddress(42, provinceId: 1);
      expect(cubit.state.selectedAddressId, 42);
      expect(cubit.state.selectedProvinceId, 1);

      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.deliveryMethods.length, 2);
      expect(cubit.state.selectedDeliveryMethod, dummyStandardDelivery);
    });

    test('loadPaymentMethods loads list and auto-selects enabled method', () async {
      await cubit.loadPaymentMethods();
      expect(cubit.state.isLoadingPaymentMethods, isFalse);
      expect(cubit.state.paymentMethods.length, 2);
      expect(cubit.state.selectedPaymentMethod, dummyCodPaymentMethod);
    });

    test('loadPaymentMethods sets error on failure', () async {
      final failCubit = CheckoutCubit(
        createTestGetDeliveryMethodsUseCase(),
        createTestGetPaymentMethodsUseCase(shouldFail: true),
        createTestPlaceOrderUseCase(),
      );
      addTearDown(failCubit.close);

      await failCubit.loadPaymentMethods();
      expect(failCubit.state.isLoadingPaymentMethods, isFalse);
      expect(failCubit.state.paymentMethodsError, 'Failed to fetch payment methods');
    });

    test('selectPaymentMethod updates state only when method isSelectable', () async {
      await cubit.loadPaymentMethods();
      expect(cubit.state.selectedPaymentMethod, dummyCodPaymentMethod);

      // card is disabled, so selection should be rejected
      cubit.selectPaymentMethod(dummyCardPaymentMethod);
      expect(cubit.state.selectedPaymentMethod, dummyCodPaymentMethod);
    });

    test('selectDeliveryMethod updates selectedDeliveryMethod in state', () {
      cubit.selectDeliveryMethod(dummyExpressDelivery);
      expect(cubit.state.selectedDeliveryMethod, dummyExpressDelivery);
    });

    test('nextStep advances step sequentially', () {
      cubit.nextStep();
      expect(cubit.state.currentStep, CheckoutStep.delivery);

      cubit.nextStep();
      expect(cubit.state.currentStep, CheckoutStep.payment);

      cubit.nextStep();
      expect(cubit.state.currentStep, CheckoutStep.review);

      cubit.nextStep();
      expect(cubit.state.currentStep, CheckoutStep.review);
    });

    test('previousStep moves backward and returns boolean indicator', () {
      expect(cubit.previousStep(), isFalse);

      cubit.nextStep();
      expect(cubit.state.currentStep, CheckoutStep.delivery);

      expect(cubit.previousStep(), isTrue);
      expect(cubit.state.currentStep, CheckoutStep.address);
    });

    test('goToStep navigates directly to requested step', () {
      cubit.goToStep(CheckoutStep.payment);
      expect(cubit.state.currentStep, CheckoutStep.payment);
    });

    test('placeOrder succeeds and updates placedOrder state', () async {
      cubit.selectDeliveryMethod(dummyStandardDelivery);
      cubit.selectPaymentMethod(dummyCodPaymentMethod);

      await cubit.placeOrder(dummyCheckoutAddress1);

      expect(cubit.state.isPlacingOrder, isFalse);
      expect(cubit.state.orderError, isNull);
      expect(cubit.state.placedOrder?.orderNumber, 'ORD-12345');
    });

    test('placeOrder handles failure and sets orderError', () async {
      final failCubit = CheckoutCubit(
        createTestGetDeliveryMethodsUseCase(),
        createTestGetPaymentMethodsUseCase(),
        createTestPlaceOrderUseCase(shouldFail: true),
      );
      addTearDown(failCubit.close);

      failCubit.selectDeliveryMethod(dummyStandardDelivery);
      failCubit.selectPaymentMethod(dummyCodPaymentMethod);

      await failCubit.placeOrder(dummyCheckoutAddress1);

      expect(failCubit.state.isPlacingOrder, isFalse);
      expect(failCubit.state.orderError, 'Failed to place order');
    });
  });
}
