import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';

/// Request DTO for creating a new address via `POST me/addresses/`.
class AddAddressRequestModel extends Equatable {
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

  const AddAddressRequestModel({
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

  factory AddAddressRequestModel.fromEntity(AddAddressParams params) {
    return AddAddressRequestModel(
      label: params.label,
      title: params.title,
      firstName: params.firstName,
      lastName: params.lastName,
      phone: params.phone,
      cityId: params.cityId,
      area: params.area,
      street: params.street,
      building: params.building,
      floor: params.floor,
      apartment: params.apartment,
      landmark: params.landmark,
      isDefault: params.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'title': title,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'city': cityId,
      'area': area,
      'street': street,
      'building': building,
      'floor': floor,
      'apartment': apartment,
      'landmark': landmark,
      'is_default': isDefault,
    };
  }

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
