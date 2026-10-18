import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String logo;
  final String coverImage;
  final bool isFeatured;
  final int productCount;

  const BrandEntity({
    required this.id,
    required this.name,
    this.slug = '',
    this.description = '',
    required this.logo,
    this.coverImage = '',
    this.isFeatured = false,
    this.productCount = 0,
  });

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
