import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';

sealed class CategoryDetailState extends Equatable {
  const CategoryDetailState();

  @override
  List<Object?> get props => [];
}

final class CategoryDetailInitial extends CategoryDetailState {
  const CategoryDetailInitial();
}

final class CategoryDetailLoading extends CategoryDetailState {
  const CategoryDetailLoading();
}

final class CategoryDetailLoaded extends CategoryDetailState {
  final CategoryDetailEntity data;
  final Set<String> wishlistedProductIds;

  const CategoryDetailLoaded({
    required this.data,
    this.wishlistedProductIds = const {},
  });

  CategoryDetailLoaded copyWith({
    CategoryDetailEntity? data,
    Set<String>? wishlistedProductIds,
  }) {
    return CategoryDetailLoaded(
      data: data ?? this.data,
      wishlistedProductIds: wishlistedProductIds ?? this.wishlistedProductIds,
    );
  }

  @override
  List<Object?> get props => [data, wishlistedProductIds];
}

final class CategoryDetailError extends CategoryDetailState {
  final String message;

  const CategoryDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
