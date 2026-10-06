import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';

/// Data model for user delivery address from `me/addresses/`.
class AddressModel extends Equatable {
  final int id;
  final String label;
  final String title;
  final String displayLabel;
  final String firstName;
  final String lastName;
  final String fullName;
  final String phone;
  final int cityId;
  final String cityName;
  final String area;
  final String street;
  final String building;
  final String floor;
  final String apartment;
  final String landmark;
  final bool isDefault;
  final String location;
  final String singleLine;
  final bool canDeliver;

  const AddressModel({
    required this.id,
    required this.label,
    required this.title,
    required this.displayLabel,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.phone,
    required this.cityId,
    required this.cityName,
    required this.area,
    required this.street,
    required this.building,
    required this.floor,
    required this.apartment,
    required this.landmark,
    required this.isDefault,
    required this.location,
    required this.singleLine,
    required this.canDeliver,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as int? ?? 0,
      label: json['label'] as String? ?? 'home',
      title: json['title'] as String? ?? '',
      displayLabel: json['display_label'] as String? ??
          json['label'] as String? ??
          'Home',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      cityId: json['city'] as int? ?? 0,
      cityName: json['city_name'] as String? ?? '',
      area: json['area'] as String? ?? '',
      street: json['street'] as String? ?? '',
      building: json['building'] as String? ?? '',
      floor: json['floor'] as String? ?? '',
      apartment: json['apartment'] as String? ?? '',
      landmark: json['landmark'] as String? ?? '',
      isDefault: json['is_default'] as bool? ?? false,
      location: json['location'] as String? ?? '',
      singleLine: json['single_line'] as String? ?? '',
      canDeliver: json['can_deliver'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'title': title,
        'display_label': displayLabel,
        'first_name': firstName,
        'last_name': lastName,
        'full_name': fullName,
        'phone': phone,
        'city': cityId,
        'city_name': cityName,
        'area': area,
        'street': street,
        'building': building,
        'floor': floor,
        'apartment': apartment,
        'landmark': landmark,
        'is_default': isDefault,
        'location': location,
        'single_line': singleLine,
        'can_deliver': canDeliver,
      };

  AddressEntity toEntity() => AddressEntity(
        id: id,
        label: label,
        title: title,
        displayLabel: displayLabel,
        firstName: firstName,
        lastName: lastName,
        fullName: fullName,
        phone: phone,
        cityId: cityId,
        cityName: cityName,
        area: area,
        street: street,
        building: building,
        floor: floor,
        apartment: apartment,
        landmark: landmark,
        isDefault: isDefault,
        location: location,
        singleLine: singleLine,
        canDeliver: canDeliver,
      );

  @override
  List<Object?> get props => [
        id,
        label,
        title,
        displayLabel,
        firstName,
        lastName,
        fullName,
        phone,
        cityId,
        cityName,
        area,
        street,
        building,
        floor,
        apartment,
        landmark,
        isDefault,
        location,
        singleLine,
        canDeliver,
      ];
}
