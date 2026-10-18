import 'package:flutter/material.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_filter_chips_group.dart';

class ProductFilterBrandsSection extends StatelessWidget {
  final ProductListFacetsEntity facets;
  final List<String> selectedBrands;
  final bool isLocked;
  final ValueChanged<String> onToggle;

  const ProductFilterBrandsSection({
    super.key,
    required this.facets,
    required this.selectedBrands,
    this.isLocked = false,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final chips = ProductFilterChipsGroup(
      title: 'BRANDS',
      items: facets.brands.map((b) => b.slug).toList(),
      selectedItems: selectedBrands,
      labelBuilder: (slug) {
        final b = facets.brands.where((x) => x.slug == slug).firstOrNull;
        return b != null ? '${b.name} (${b.count})' : slug;
      },
      onToggle: isLocked ? (_) {} : onToggle,
    );

    if (isLocked) {
      return Opacity(
        opacity: 0.45,
        child: IgnorePointer(child: chips),
      );
    }

    return chips;
  }
}
