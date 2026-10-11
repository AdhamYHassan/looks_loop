import 'package:looks_loop/features/home/domain/entities/home_category_entity.dart';

class SubcategoryModel extends SubcategoryEntity {
  const SubcategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.imageUrl,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
    );
  }
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    super.slug,
    super.tagline,
    required super.imageUrl,
    super.subcategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final rawSubs = json['subcategories'] as List<dynamic>? ?? const [];
    final subs = rawSubs
        .whereType<Map<String, dynamic>>()
        .map(SubcategoryModel.fromJson)
        .toList();

    return CategoryModel(
      id: (json['id'] ?? '').toString(),
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      imageUrl:
          json['image'] as String? ?? (json['image_url'] as String? ?? ''),
      subcategories: subs,
    );
  }
}
