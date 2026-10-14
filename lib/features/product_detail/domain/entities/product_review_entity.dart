import 'package:equatable/equatable.dart';

class ProductReviewEntity extends Equatable {
  final String id;
  final String authorName;
  final String dateText;
  final int rating;
  final String body;
  final String sizePurchased;
  final int helpfulCount;
  final String? storeReply;

  const ProductReviewEntity({
    required this.id,
    required this.authorName,
    required this.dateText,
    required this.rating,
    required this.body,
    required this.sizePurchased,
    required this.helpfulCount,
    this.storeReply,
  });

  @override
  List<Object?> get props => [
        id,
        authorName,
        dateText,
        rating,
        body,
        sizePurchased,
        helpfulCount,
        storeReply,
      ];
}
