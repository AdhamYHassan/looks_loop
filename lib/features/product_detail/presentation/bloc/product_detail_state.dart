import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_variant_entity.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial();
}

final class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
}

final class ProductDetailError extends ProductDetailState {
  final String message;

  const ProductDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

final class ProductDetailLoaded extends ProductDetailState {
  final ProductDetailEntity product;
  final int? selectedColorId;
  final int? selectedSizeId;
  final ProductVariantEntity? selectedVariant;
  final int selectedImageIndex;
  final int? expandedSectionIndex;
  final bool isWishlisted;
  final Set<String> helpfulReviewIds;
  final int bagCount;
  final bool isAddingToBag;
  final String? bagActionMessage;

  const ProductDetailLoaded({
    required this.product,
    this.selectedColorId,
    this.selectedSizeId,
    this.selectedVariant,
    this.selectedImageIndex = 0,
    this.expandedSectionIndex = 0,
    this.isWishlisted = false,
    this.helpfulReviewIds = const {},
    this.bagCount = 3,
    this.isAddingToBag = false,
    this.bagActionMessage,
  });

  bool isSizeAvailable(int sizeId) {
    if (selectedColorId != null) {
      return product.isSizeAvailableForColor(
        sizeId: sizeId,
        colorId: selectedColorId!,
      );
    }
    return product.variants.any(
      (v) => v.sizeId == sizeId && v.isAvailable && v.stock > 0,
    );
  }

  bool get isSelectedVariantAvailable {
    if (product.variants.isEmpty) return product.inStock;
    return selectedVariant != null &&
        selectedVariant!.isAvailable &&
        selectedVariant!.stock > 0;
  }

  ProductDetailLoaded copyWith({
    ProductDetailEntity? product,
    int? selectedColorId,
    int? selectedSizeId,
    ProductVariantEntity? Function()? selectedVariant,
    int? selectedImageIndex,
    int? Function()? expandedSectionIndex,
    bool? isWishlisted,
    Set<String>? helpfulReviewIds,
    int? bagCount,
    bool? isAddingToBag,
    String? Function()? bagActionMessage,
  }) {
    return ProductDetailLoaded(
      product: product ?? this.product,
      selectedColorId: selectedColorId ?? this.selectedColorId,
      selectedSizeId: selectedSizeId ?? this.selectedSizeId,
      selectedVariant: selectedVariant != null
          ? selectedVariant()
          : this.selectedVariant,
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      expandedSectionIndex: expandedSectionIndex != null
          ? expandedSectionIndex()
          : this.expandedSectionIndex,
      isWishlisted: isWishlisted ?? this.isWishlisted,
      helpfulReviewIds: helpfulReviewIds ?? this.helpfulReviewIds,
      bagCount: bagCount ?? this.bagCount,
      isAddingToBag: isAddingToBag ?? this.isAddingToBag,
      bagActionMessage: bagActionMessage != null
          ? bagActionMessage()
          : this.bagActionMessage,
    );
  }

  @override
  List<Object?> get props => [
        product,
        selectedColorId,
        selectedSizeId,
        selectedVariant,
        selectedImageIndex,
        expandedSectionIndex,
        isWishlisted,
        helpfulReviewIds,
        bagCount,
        isAddingToBag,
        bagActionMessage,
      ];
}
