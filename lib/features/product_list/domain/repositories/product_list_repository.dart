import 'package:equatable/equatable.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';

class GetProductsParams extends Equatable {
  final String category;
  final String subcategory;
  final int page;
  final int pageSize;
  final String? sort;
  final String? q;
  final List<String> brands;
  final List<String> sizes;
  final List<String> colors;
  final bool? sale;
  final bool? newIn;
  final bool? trending;

  const GetProductsParams({
    required this.category,
    required this.subcategory,
    this.page = 1,
    this.pageSize = 10,
    this.sort,
    this.q,
    this.brands = const [],
    this.sizes = const [],
    this.colors = const [],
    this.sale,
    this.newIn,
    this.trending,
  });

  Map<String, dynamic> toQueryParameters() {
    final query = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
    };
    if (category.isNotEmpty && category != 'all') {
      query['category'] = category;
    }
    if (subcategory.isNotEmpty && subcategory != 'all') {
      query['subcategory'] = subcategory;
    }
    if (sort != null && sort!.isNotEmpty) query['sort'] = sort;
    if (q != null && q!.trim().isNotEmpty) query['q'] = q!.trim();
    if (brands.isNotEmpty) query['brand'] = brands;
    if (sizes.isNotEmpty) query['size'] = sizes;
    if (colors.isNotEmpty) query['color'] = colors;
    if (sale == true) query['sale'] = 1;
    if (newIn == true) query['new'] = 1;
    if (trending == true) query['trending'] = true;
    return query;
  }

  @override
  List<Object?> get props => [
        category,
        subcategory,
        page,
        pageSize,
        sort,
        q,
        brands,
        sizes,
        colors,
        sale,
        newIn,
        trending,
      ];
}

abstract interface class ProductListRepository {
  Future<ApiResult<ProductListEntity>> getProducts(GetProductsParams params);
}
