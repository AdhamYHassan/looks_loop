import 'package:equatable/equatable.dart';

class WishlistAddRequestModel extends Equatable {
  final int productId;

  const WishlistAddRequestModel({required this.productId});

  Map<String, dynamic> toJson() => {
        'product_id': productId,
      };

  @override
  List<Object?> get props => [productId];
}
