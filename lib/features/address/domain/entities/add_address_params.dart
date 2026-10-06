import 'package:equatable/equatable.dart';

/// Parameters for creating a new user address.
class AddAddressParams extends Equatable {
  final String label;
  final String title;
  final String firstName;
  final String lastName;
  final String phone;
  final int cityId;
  final String area;
  final String street;
  final String building;
  final String floor;
  final String apartment;
  final String landmark;
  final bool isDefault;

  const AddAddressParams({
    required this.label,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.cityId,
    required this.area,
    required this.street,
    required this.building,
    required this.floor,
    required this.apartment,
    required this.landmark,
    this.isDefault = true,
  });

  @override
  List<Object?> get props => [
        label,
        title,
        firstName,
        lastName,
        phone,
        cityId,
        area,
        street,
        building,
        floor,
        apartment,
        landmark,
        isDefault,
      ];
}
