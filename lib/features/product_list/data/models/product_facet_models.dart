import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';

class SortOptionModel extends SortOptionEntity {
  const SortOptionModel({required super.value, required super.label});

  factory SortOptionModel.fromJson(Map<String, dynamic> json) {
    return SortOptionModel(
      value: json['value'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }
}

class BrandFacetModel extends BrandFacetEntity {
  const BrandFacetModel({
    required super.slug,
    required super.name,
    required super.count,
  });

  factory BrandFacetModel.fromJson(Map<String, dynamic> json) {
    return BrandFacetModel(
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      count: json['count'] as int? ?? 0,
    );
  }
}

class ColorFacetModel extends ColorFacetEntity {
  const ColorFacetModel({
    required super.name,
    required super.hex,
  });

  factory ColorFacetModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      final name = (json['name'] ?? json['hex'] ?? '').toString();
      final hex = (json['hex'] ?? '').toString();
      return ColorFacetModel(name: name, hex: hex);
    }
    final str = json.toString();
    return ColorFacetModel(
      name: str,
      hex: str.startsWith('#') ? str : '',
    );
  }
}

class ProductListFacetsModel extends ProductListFacetsEntity {
  const ProductListFacetsModel({
    super.brands,
    super.sizes,
    super.colors,
  });

  factory ProductListFacetsModel.fromJson(Map<String, dynamic> json) {
    final rawBrands = json['brands'] as List<dynamic>? ?? [];
    final brands = rawBrands
        .whereType<Map<String, dynamic>>()
        .map(BrandFacetModel.fromJson)
        .toList();

    final rawSizes = json['sizes'] as List<dynamic>? ?? [];
    final sizes = rawSizes.map((e) => e.toString()).toList();

    final rawColors = json['colors'] as List<dynamic>? ?? [];
    final colors = rawColors.map(ColorFacetModel.fromJson).toList();

    return ProductListFacetsModel(
      brands: brands,
      sizes: sizes,
      colors: colors,
    );
  }
}

class SelectedFiltersModel extends SelectedFiltersEntity {
  const SelectedFiltersModel({
    super.brands,
    super.sizes,
    super.colors,
    super.sale,
    super.newIn,
  });

  factory SelectedFiltersModel.fromJson(Map<String, dynamic> json) {
    final rawBrands = json['brands'] as List<dynamic>? ?? [];
    final rawSizes = json['sizes'] as List<dynamic>? ?? [];
    final rawColors = json['colors'] as List<dynamic>? ?? [];

    return SelectedFiltersModel(
      brands: rawBrands.map((e) => e.toString()).toList(),
      sizes: rawSizes.map((e) => e.toString()).toList(),
      colors: rawColors.map((e) {
        if (e is Map<String, dynamic>) {
          return (e['name'] ?? e['hex'] ?? '').toString();
        }
        return e.toString();
      }).toList(),
      sale: json['sale'] as bool? ?? false,
      newIn: json['new'] as bool? ?? false,
    );
  }
}
