import 'package:looks_loop/features/address/data/models/city_model.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';

/// Data model for Province/Governorate with nested cities.
class ProvinceModel {
  final int id;
  final int countryId;
  final String name;
  final String nameEn;
  final String nameAr;
  final double? deliveryFee;
  final double? freeDeliveryThreshold;
  final List<CityModel> cities;

  const ProvinceModel({
    required this.id,
    required this.countryId,
    required this.name,
    required this.nameEn,
    required this.nameAr,
    this.deliveryFee,
    this.freeDeliveryThreshold,
    required this.cities,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    final rawCities = json['cities'];
    final citiesList = rawCities is List
        ? rawCities
            .whereType<Map<String, dynamic>>()
            .map(CityModel.fromJson)
            .toList()
        : <CityModel>[];

    return ProvinceModel(
      id: json['id'] as int? ?? 0,
      countryId: json['country'] as int? ?? 1,
      name: json['name'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? json['name'] as String? ?? '',
      nameAr: json['name_ar'] as String? ?? json['name'] as String? ?? '',
      deliveryFee: parseDouble(json['delivery_fee']),
      freeDeliveryThreshold: parseDouble(json['free_delivery_threshold']),
      cities: citiesList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'country': countryId,
        'name': name,
        'name_en': nameEn,
        'name_ar': nameAr,
        'delivery_fee': deliveryFee?.toStringAsFixed(2),
        'free_delivery_threshold': freeDeliveryThreshold?.toStringAsFixed(2),
        'cities': cities.map((c) => c.toJson()).toList(),
      };

  ProvinceEntity toEntity() => ProvinceEntity(
        id: id,
        countryId: countryId,
        name: name,
        nameEn: nameEn,
        nameAr: nameAr,
        deliveryFee: deliveryFee,
        freeDeliveryThreshold: freeDeliveryThreshold,
        cities: cities.map((c) => c.toEntity()).toList(),
      );
}
