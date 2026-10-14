import 'package:equatable/equatable.dart';

class ProductImageEntity extends Equatable {
  final int id;
  final String url;
  final int? colorId;
  final String alt;
  final bool isPrimary;

  const ProductImageEntity({
    required this.id,
    required this.url,
    this.colorId,
    this.alt = '',
    this.isPrimary = false,
  });

  @override
  List<Object?> get props => [id, url, colorId, alt, isPrimary];
}
