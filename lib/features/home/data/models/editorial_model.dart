import 'package:looks_loop/features/home/domain/entities/editorial_entity.dart';

class EditorialModel extends EditorialEntity {
  const EditorialModel({
    required super.id,
    required super.eyebrow,
    required super.title,
    super.highlight,
    required super.copy,
    required super.ctaLabel,
    super.ctaUrl,
    required super.imageUrl,
  });

  factory EditorialModel.fromJson(Map<String, dynamic> json) {
    return EditorialModel(
      id: json['id'] as int? ?? 0,
      eyebrow: json['eyebrow'] as String? ?? '',
      title: json['title'] as String? ?? '',
      highlight: json['highlight'] as String? ?? '',
      copy: json['copy'] as String? ?? '',
      ctaLabel: json['cta_label'] as String? ?? '',
      ctaUrl: json['cta_url'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
    );
  }
}
