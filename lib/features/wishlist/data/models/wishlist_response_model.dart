import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/data/models/product_models.dart';

class WishlistResponseModel extends Equatable {
  final bool status;
  final int statusCode;
  final String message;
  final List<ProductModel> items;

  const WishlistResponseModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory WishlistResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final List<ProductModel> parsedItems;

    if (rawData is List) {
      parsedItems = rawData
          .whereType<Map<String, dynamic>>()
          .map(ProductModel.fromJson)
          .toList();
    } else if (rawData is Map<String, dynamic>) {
      final results = rawData['results'];
      if (results is List) {
        parsedItems = results
            .whereType<Map<String, dynamic>>()
            .map(ProductModel.fromJson)
            .toList();
      } else {
        parsedItems = [ProductModel.fromJson(rawData)];
      }
    } else {
      parsedItems = const [];
    }

    return WishlistResponseModel(
      status: json['status'] as bool? ?? false,
      statusCode: json['status_code'] as int? ?? 200,
      message: json['message'] as String? ?? '',
      items: parsedItems,
    );
  }

  @override
  List<Object?> get props => [status, statusCode, message, items];
}
