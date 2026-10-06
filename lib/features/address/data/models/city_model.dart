import 'package:looks_loop/features/address/domain/entities/city_entity.dart';

/// Data model for City JSON serialization without code generation.
class CityModel {
  final int id;
  final int provinceId;
  final String name;
  final String nameEn;
  final String nameAr;

  const CityModel({
    required this.id,
    required this.provinceId,
    required this.name,
    required this.nameEn,
    required this.nameAr,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int? ?? 0,
      provinceId: json['province'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? json['name'] as String? ?? '',
      nameAr: json['name_ar'] as String? ?? json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'province': provinceId,
        'name': name,
        'name_en': nameEn,
        'name_ar': nameAr,
      };

  CityEntity toEntity() => CityEntity(
        id: id,
        provinceId: provinceId,
        name: name,
        nameEn: nameEn,
        nameAr: nameAr,
      );
}
