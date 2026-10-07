import 'package:equatable/equatable.dart';

class OrderAddressEntity extends Equatable {
  final String fullName;
  final String phone;
  final String street;
  final String building;
  final String floor;
  final String apartment;
  final String area;
  final String city;
  final String fullAddress;

  const OrderAddressEntity({
    required this.fullName,
    required this.phone,
    required this.street,
    required this.building,
    required this.floor,
    required this.apartment,
    required this.area,
    required this.city,
    required this.fullAddress,
  });

  @override
  List<Object?> get props => [
        fullName,
        phone,
        street,
        building,
        floor,
        apartment,
        area,
        city,
        fullAddress,
      ];
}
