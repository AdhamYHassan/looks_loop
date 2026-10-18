import 'package:equatable/equatable.dart';

class GetBrandsParams extends Equatable {
  final String? category;
  final bool? featured;
  final String? q;

  const GetBrandsParams({
    this.category,
    this.featured,
    this.q,
  });

  Map<String, dynamic> toQueryParameters() {
    final query = <String, dynamic>{};
    if (category != null && category!.trim().isNotEmpty) {
      query['category'] = category!.trim();
    }
    if (featured != null) {
      query['featured'] = featured;
    }
    if (q != null && q!.trim().isNotEmpty) {
      query['q'] = q!.trim();
    }
    return query;
  }

  @override
  List<Object?> get props => [category, featured, q];
}
