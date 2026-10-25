import 'package:flutter/material.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';

class AddressFormControllers {
  final TextEditingController first;
  final TextEditingController last;
  final TextEditingController phone;
  final TextEditingController area;
  final TextEditingController street;
  final TextEditingController building;
  final TextEditingController floor;
  final TextEditingController apt;
  final TextEditingController landmark;

  AddressFormControllers.fromAddress(AddressEntity? addr)
      : first = TextEditingController(text: addr?.firstName ?? ''),
        last = TextEditingController(text: addr?.lastName ?? ''),
        phone = TextEditingController(text: addr?.phone ?? ''),
        area = TextEditingController(text: addr?.area ?? ''),
        street = TextEditingController(text: addr?.street ?? ''),
        building = TextEditingController(text: addr?.building ?? ''),
        floor = TextEditingController(text: addr?.floor ?? ''),
        apt = TextEditingController(text: addr?.apartment ?? ''),
        landmark = TextEditingController(text: addr?.landmark ?? '');

  void dispose() {
    first.dispose();
    last.dispose();
    phone.dispose();
    area.dispose();
    street.dispose();
    building.dispose();
    floor.dispose();
    apt.dispose();
    landmark.dispose();
  }

  AddAddressParams toParams({
    required String label,
    required int cityId,
    required bool isDefault,
  }) {
    return AddAddressParams(
      label: label,
      title: label,
      firstName: first.text.trim(),
      lastName: last.text.trim(),
      phone: phone.text.trim(),
      cityId: cityId,
      area: area.text.trim(),
      street: street.text.trim(),
      building: building.text.trim(),
      floor: floor.text.trim(),
      apartment: apt.text.trim(),
      landmark: landmark.text.trim(),
      isDefault: isDefault,
    );
  }
}
