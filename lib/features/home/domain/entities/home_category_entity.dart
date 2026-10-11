import 'package:equatable/equatable.dart';

class SubcategoryEntity extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String imageUrl;

  const SubcategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.imageUrl = '',
  });

  @override
  List<Object?> get props => [id, name, slug, imageUrl];
}

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String tagline;
  final String imageUrl;
  final List<SubcategoryEntity> subcategories;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.slug = '',
    this.tagline = '',
    required this.imageUrl,
    this.subcategories = const [],
  });

  @override
  List<Object?> get props => [id, name, slug, tagline, imageUrl, subcategories];
}
