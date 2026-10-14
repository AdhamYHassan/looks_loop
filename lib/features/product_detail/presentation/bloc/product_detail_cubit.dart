import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/add_to_cart_params.dart';
import 'package:looks_loop/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:looks_loop/features/product_detail/domain/usecases/get_product_detail_usecase.dart';
import 'package:looks_loop/features/product_detail/presentation/bloc/product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetailUseCase _getProductDetailUseCase;
  final AddToCartUseCase _addToCartUseCase;

  ProductDetailCubit(
    this._getProductDetailUseCase,
    this._addToCartUseCase,
  ) : super(const ProductDetailInitial());

  Future<void> loadProductDetail(String slug) async {
    emit(const ProductDetailLoading());
    final result = await _getProductDetailUseCase(slug);

    switch (result) {
      case ApiSuccess(:final data):
        final colorId = data.colors.firstOrNull?.id;
        final size = data.findDefaultSize(colorId);
        final variant = (colorId != null && size != null)
            ? data.getVariant(sizeId: size.id, colorId: colorId)
            : null;

        emit(ProductDetailLoaded(
          product: data,
          selectedColorId: colorId,
          selectedSizeId: size?.id,
          selectedVariant: variant,
          isWishlisted: data.isWishlisted,
        ));
      case ApiFailure(:final failure):
        emit(ProductDetailError(failure.message));
    }
  }

  void selectImage(int index) {
    if (state is ProductDetailLoaded) {
      emit((state as ProductDetailLoaded).copyWith(selectedImageIndex: index));
    }
  }

  void selectColor(int colorId) {
    if (state is! ProductDetailLoaded) return;
    final curr = state as ProductDetailLoaded;
    var sizeId = curr.selectedSizeId;

    if (sizeId == null || !curr.product.isSizeAvailableForColor(sizeId: sizeId, colorId: colorId)) {
      sizeId = curr.product.findDefaultSize(colorId)?.id;
    }

    final variant = sizeId != null
        ? curr.product.getVariant(sizeId: sizeId, colorId: colorId)
        : null;
    final imgIdx = curr.product.images.indexWhere((img) => img.colorId == colorId);

    emit(curr.copyWith(
      selectedColorId: colorId,
      selectedSizeId: sizeId,
      selectedVariant: () => variant,
      selectedImageIndex: imgIdx != -1 ? imgIdx : null,
    ));
  }

  void selectSize(int sizeId) {
    if (state is! ProductDetailLoaded) return;
    final curr = state as ProductDetailLoaded;
    final colorId = curr.selectedColorId;
    if (colorId == null) return;

    if (curr.product.isSizeAvailableForColor(sizeId: sizeId, colorId: colorId)) {
      final variant = curr.product.getVariant(sizeId: sizeId, colorId: colorId);
      emit(curr.copyWith(selectedSizeId: sizeId, selectedVariant: () => variant));
    }
  }

  void toggleSection(int sectionIndex) {
    if (state is! ProductDetailLoaded) return;
    final curr = state as ProductDetailLoaded;
    final newIdx = curr.expandedSectionIndex == sectionIndex ? null : sectionIndex;
    emit(curr.copyWith(expandedSectionIndex: () => newIdx));
  }

  void toggleWishlist() {
    if (state is ProductDetailLoaded) {
      final curr = state as ProductDetailLoaded;
      emit(curr.copyWith(isWishlisted: !curr.isWishlisted));
    }
  }

  void toggleReviewHelpful(String reviewId) {
    if (state is! ProductDetailLoaded) return;
    final curr = state as ProductDetailLoaded;
    final updated = Set<String>.from(curr.helpfulReviewIds);
    if (!updated.add(reviewId)) updated.remove(reviewId);
    emit(curr.copyWith(helpfulReviewIds: updated));
  }

  Future<void> addToBag({int quantity = 1}) async {
    if (state is! ProductDetailLoaded) return;
    final curr = state as ProductDetailLoaded;
    if (curr.isAddingToBag) return;

    final p = curr.product;
    emit(curr.copyWith(isAddingToBag: true, bagActionMessage: () => null));

    final params = AddToCartParams(
      variantId: curr.selectedVariant?.id ?? 0,
      productId: p.id,
      colorId: curr.selectedColorId ?? (p.colors.firstOrNull?.id ?? 0),
      sizeId: curr.selectedSizeId ?? (p.sizes.firstOrNull?.id ?? 0),
      quantity: quantity,
    );

    final result = await _addToCartUseCase(params);
    if (isClosed) return;

    switch (result) {
      case ApiSuccess():
        emit(curr.copyWith(
          isAddingToBag: false,
          bagCount: curr.bagCount + quantity,
          bagActionMessage: () => 'Added to bag',
        ));
      case ApiFailure(:final failure):
        emit(curr.copyWith(
          isAddingToBag: false,
          bagActionMessage: () => failure.message,
        ));
    }
  }
}
