import 'package:equatable/equatable.dart';

class PlaceOrderRequestModel extends Equatable {
  final int addressId;
  final String deliveryMethod;
  final String paymentMethod;
  final String note;
  final String fullName;
  final String phone;
  final String email;

  const PlaceOrderRequestModel({
    required this.addressId,
    required this.deliveryMethod,
    required this.paymentMethod,
    this.note = '',
    required this.fullName,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'address_id': addressId,
        'delivery_method': deliveryMethod,
        'payment_method': paymentMethod,
        'note': note,
        'full_name': fullName,
        'phone': phone,
        'email': email,
      };

  @override
  List<Object?> get props => [
        addressId,
        deliveryMethod,
        paymentMethod,
        note,
        fullName,
        phone,
        email,
      ];
}
