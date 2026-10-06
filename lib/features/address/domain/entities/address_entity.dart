import 'package:equatable/equatable.dart';

/// Domain entity representing a user delivery location/address.
class AddressEntity extends Equatable {
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

  const AddressEntity({
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

  /// Formatted compact display of street, building, and apartment
  String get formattedAddress {
    if (singleLine.isNotEmpty) return singleLine;
    final parts = [
      if (building.isNotEmpty) 'Bldg $building',
      if (street.isNotEmpty) street,
      if (floor.isNotEmpty) 'Fl $floor',
      if (apartment.isNotEmpty) 'Apt $apartment',
      if (area.isNotEmpty) area,
      if (cityName.isNotEmpty) cityName,
    ];
    return parts.join(', ');
  }

  /// Contact recipient display name
  String get contactName {
    if (fullName.isNotEmpty) return fullName;
    final combined = '$firstName $lastName'.trim();
    return combined.isNotEmpty ? combined : phone;
  }

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
