import 'package:equatable/equatable.dart';

/// Domain entity representing a City in Egypt.
class CityEntity extends Equatable {
  final int id;
  final int provinceId;
  final String name;
  final String nameEn;
  final String nameAr;

  const CityEntity({
    required this.id,
    required this.provinceId,
    required this.name,
    required this.nameEn,
    required this.nameAr,
  });

  /// Localized name helper based on language code.
  String localizedName(String langCode) =>
      langCode == 'ar' ? nameAr : nameEn;

  @override
  List<Object?> get props => [id, provinceId, name, nameEn, nameAr];
}
