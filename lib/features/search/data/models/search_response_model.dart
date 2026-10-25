import 'package:looks_loop/features/home/data/models/product_models.dart';
import 'package:looks_loop/features/search/domain/entities/search_result_entity.dart';

class SearchBrandModel extends SearchBrandEntity {
  const SearchBrandModel({
    required super.id,
    required super.name,
    required super.slug,
    super.logo,
  });

  factory SearchBrandModel.fromJson(Map<String, dynamic> json) {
    return SearchBrandModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      logo: json['logo'] as String?,
    );
  }
}

class SearchCategoryModel extends SearchCategoryEntity {
  const SearchCategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.image,
  });

  factory SearchCategoryModel.fromJson(Map<String, dynamic> json) {
    return SearchCategoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      image: json['image'] as String?,
    );
  }
}

class SearchResponseModel extends SearchResultEntity {
  const SearchResponseModel({
    super.products,
    super.brands,
    super.categories,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final rawProducts = rawData['products'] as List<dynamic>? ?? const [];
    final products = rawProducts
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();

    final rawBrands = rawData['brands'] as List<dynamic>? ?? const [];
    final brands = rawBrands
        .whereType<Map<String, dynamic>>()
        .map(SearchBrandModel.fromJson)
        .toList();

    final rawCategories = rawData['categories'] as List<dynamic>? ?? const [];
    final categories = rawCategories
        .whereType<Map<String, dynamic>>()
        .map(SearchCategoryModel.fromJson)
        .toList();

    return SearchResponseModel(
      products: products,
      brands: brands,
      categories: categories,
    );
  }
}
