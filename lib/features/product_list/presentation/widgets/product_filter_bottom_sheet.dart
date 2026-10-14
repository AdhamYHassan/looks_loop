import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_filter_apply_button.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_filter_chips_group.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_filter_sheet_header.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_filter_special_offers.dart';

class ProductFilterBottomSheet extends StatefulWidget {
  final ProductListFacetsEntity facets;
  final SelectedFiltersEntity currentFilters;
  final ValueChanged<SelectedFiltersEntity> onApply;

  const ProductFilterBottomSheet({
    super.key,
    required this.facets,
    required this.currentFilters,
    required this.onApply,
  });

  static Future<void> show(
    BuildContext context, {
    required ProductListFacetsEntity facets,
    required SelectedFiltersEntity currentFilters,
    required ValueChanged<SelectedFiltersEntity> onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorManager.getBackground(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => ProductFilterBottomSheet(
        facets: facets,
        currentFilters: currentFilters,
        onApply: onApply,
      ),
    );
  }

  @override
  State<ProductFilterBottomSheet> createState() =>
      _ProductFilterBottomSheetState();
}

class _ProductFilterBottomSheetState extends State<ProductFilterBottomSheet> {
  late List<String> _selectedBrands;
  late List<String> _selectedSizes;
  late List<String> _selectedColors;
  late bool _sale;
  late bool _newIn;

  @override
  void initState() {
    super.initState();
    _selectedBrands = List.from(widget.currentFilters.brands);
    _selectedSizes = List.from(widget.currentFilters.sizes);
    _selectedColors = List.from(widget.currentFilters.colors);
    _sale = widget.currentFilters.sale;
    _newIn = widget.currentFilters.newIn;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            ProductFilterSheetHeader(onReset: _resetFilters),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                children: [
                  ProductFilterChipsGroup(
                    title: 'BRANDS',
                    items: widget.facets.brands.map((b) => b.slug).toList(),
                    selectedItems: _selectedBrands,
                    labelBuilder: (slug) {
                      final b = widget.facets.brands.firstWhere((x) => x.slug == slug);
                      return '${b.name} (${b.count})';
                    },
                    onToggle: (slug) => setState(() {
                      if (!_selectedBrands.remove(slug)) _selectedBrands.add(slug);
                    }),
                  ),
                  ProductFilterChipsGroup(
                    title: 'SIZES',
                    items: widget.facets.sizes,
                    selectedItems: _selectedSizes,
                    onToggle: (s) => setState(() {
                      if (!_selectedSizes.remove(s)) _selectedSizes.add(s);
                    }),
                  ),
                  ProductFilterChipsGroup(
                    title: 'COLORS',
                    items: widget.facets.colors,
                    selectedItems: _selectedColors,
                    onToggle: (c) => setState(() {
                      if (!_selectedColors.remove(c)) _selectedColors.add(c);
                    }),
                  ),
                  ProductFilterSpecialOffers(
                    sale: _sale,
                    newIn: _newIn,
                    onSaleChanged: (v) => setState(() => _sale = v),
                    onNewInChanged: (v) => setState(() => _newIn = v),
                  ),
                ],
              ),
            ),
            ProductFilterApplyButton(
              onApply: () {
                Navigator.of(context).pop();
                widget.onApply(SelectedFiltersEntity(
                  brands: _selectedBrands,
                  sizes: _selectedSizes,
                  colors: _selectedColors,
                  sale: _sale,
                  newIn: _newIn,
                ));
              },
            ),
          ],
        );
      },
    );
  }

  void _resetFilters() {
    setState(() {
      _selectedBrands.clear();
      _selectedSizes.clear();
      _selectedColors.clear();
      _sale = false;
      _newIn = false;
    });
  }
}
