import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/checkout/domain/entities/checkout_step.dart';

class CheckoutState extends Equatable {
  final CheckoutStep currentStep;
  final int? selectedAddressId;
  final String deliveryMethod;
  final String paymentMethod;

  const CheckoutState({
    this.currentStep = CheckoutStep.address,
    this.selectedAddressId,
    this.deliveryMethod = 'standard',
    this.paymentMethod = 'cod',
  });

  CheckoutState copyWith({
    CheckoutStep? currentStep,
    int? Function()? selectedAddressId,
    String? deliveryMethod,
    String? paymentMethod,
  }) {
    return CheckoutState(
      currentStep: currentStep ?? this.currentStep,
      selectedAddressId: selectedAddressId != null
          ? selectedAddressId()
          : this.selectedAddressId,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        selectedAddressId,
        deliveryMethod,
        paymentMethod,
      ];
}
