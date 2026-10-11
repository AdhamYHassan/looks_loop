import 'package:equatable/equatable.dart';

class EditorialEntity extends Equatable {
  final int id;
  final String eyebrow;
  final String title;
  final String highlight;
  final String copy;
  final String ctaLabel;
  final String ctaUrl;
  final String imageUrl;

  const EditorialEntity({
    required this.id,
    required this.eyebrow,
    required this.title,
    this.highlight = '',
    required this.copy,
    required this.ctaLabel,
    this.ctaUrl = '',
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        eyebrow,
        title,
        highlight,
        copy,
        ctaLabel,
        ctaUrl,
        imageUrl,
      ];
}
