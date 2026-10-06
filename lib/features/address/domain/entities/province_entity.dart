import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/address/domain/entities/city_entity.dart';

/// Domain entity representing an Egyptian Governorate (Province) with dynamic delivery fees.
class ProvinceEntity extends Equatable {
  final int id;
  final int countryId;
  final String name;
  final String nameEn;
  final String nameAr;
  final double? deliveryFee;
  final double? freeDeliveryThreshold;
  final List<CityEntity> cities;

  const ProvinceEntity({
    required this.id,
    required this.countryId,
    required this.name,
    required this.nameEn,
    required this.nameAr,
    this.deliveryFee,
    this.freeDeliveryThreshold,
    required this.cities,
  });

  /// Localized name helper based on language code.
  String localizedName(String langCode) =>
      langCode == 'ar' ? nameAr : nameEn;

  @override
  List<Object?> get props => [
        id,
        countryId,
        name,
        nameEn,
        nameAr,
        deliveryFee,
        freeDeliveryThreshold,
        cities,
      ];
}
