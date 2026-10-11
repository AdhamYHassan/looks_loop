import 'package:equatable/equatable.dart';

class HomeBrandEntity extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String logo;
  final String coverImage;
  final bool isFeatured;
  final int productCount;

  const HomeBrandEntity({
    required this.id,
    required this.name,
    this.slug = '',
    this.description = '',
    required this.logo,
    this.coverImage = '',
    this.isFeatured = true,
    this.productCount = 0,
  });

  String get logoAssetOrUrl => logo;

  @override
  List<Object?> get props => [
        id,
        name,
        slug,
        description,
        logo,
        coverImage,
        isFeatured,
        productCount,
      ];
}

typedef BrandEntity = HomeBrandEntity;
