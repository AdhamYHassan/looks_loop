import 'package:equatable/equatable.dart';

class RatingDistributionEntity extends Equatable {
  final int star;
  final int count;
  final double percentage;

  const RatingDistributionEntity({
    required this.star,
    required this.count,
    required this.percentage,
  });

  @override
  List<Object?> get props => [star, count, percentage];
}
