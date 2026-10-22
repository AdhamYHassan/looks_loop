import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/features/checkout/domain/entities/checkout_step.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(const CheckoutState());

  void selectAddress(int addressId) {
    emit(state.copyWith(selectedAddressId: () => addressId));
  }

  void selectDeliveryMethod(String method) {
    emit(state.copyWith(deliveryMethod: method));
  }

  void selectPaymentMethod(String method) {
    emit(state.copyWith(paymentMethod: method));
  }

  void goToStep(CheckoutStep step) {
    emit(state.copyWith(currentStep: step));
  }

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
