import 'package:equatable/equatable.dart';

class ProductSizeEntity extends Equatable {
  final int id;
  final String label;

  const ProductSizeEntity({
    required this.id,
    required this.label,
  });

  @override
  List<Object?> get props => [id, label];
}
