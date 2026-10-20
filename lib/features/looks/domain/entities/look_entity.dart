import 'package:equatable/equatable.dart';

export 'package:looks_loop/features/home/domain/entities/featured_look_entity.dart';

class LookSummaryEntity extends Equatable {
  final int id;
  final String slug;
  final String title;
  final String description;
  final String image;
  final bool isFeatured;

  const LookSummaryEntity({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.image,
    this.isFeatured = false,
  });

  @override
  List<Object?> get props => [id, slug, title, description, image, isFeatured];
}
