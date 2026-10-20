import 'package:looks_loop/features/looks/domain/entities/look_entity.dart';

export 'package:looks_loop/features/home/data/models/featured_look_model.dart';

class LookSummaryModel extends LookSummaryEntity {
  const LookSummaryModel({
    required super.id,
    required super.slug,
    required super.title,
    required super.description,
    required super.image,
    super.isFeatured,
  });

  factory LookSummaryModel.fromJson(Map<String, dynamic> json) {
    return LookSummaryModel(
      id: json['id'] as int? ?? 0,
      slug: json['slug'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      isFeatured: json['is_featured'] as bool? ?? false,
    );
  }
}
