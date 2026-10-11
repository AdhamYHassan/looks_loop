import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

class HeroSlideModel extends HeroSlideEntity {
  const HeroSlideModel({
    required super.id,
    required super.eyebrow,
    required super.title,
    super.titleLines,
    required super.copy,
    required super.image,
    required super.primaryLabel,
    super.primaryUrl,
    required super.secondaryLabel,
    super.secondaryUrl,
  });

  factory HeroSlideModel.fromJson(Map<String, dynamic> json) {
    final rawLines = json['title_lines'] as List<dynamic>? ?? const [];
    return HeroSlideModel(
      id: json['id'] as int? ?? 0,
      eyebrow: json['eyebrow'] as String? ?? '',
      title: json['title'] as String? ?? '',
      titleLines: rawLines.map((e) => e.toString()).toList(),
      copy: json['copy'] as String? ?? '',
      image: json['image'] as String? ?? (json['image_url'] as String? ?? ''),
      primaryLabel: json['primary_label'] as String? ?? '',
      primaryUrl: json['primary_url'] as String? ?? '',
      secondaryLabel: json['secondary_label'] as String? ?? '',
      secondaryUrl: json['secondary_url'] as String? ?? '',
    );
  }
}
