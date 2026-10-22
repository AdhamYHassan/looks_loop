import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/add_to_cart_params.dart';
import 'package:looks_loop/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:looks_loop/features/product_detail/domain/usecases/get_product_detail_usecase.dart';

class AddLookProductToCartUseCase {
  final GetProductDetailUseCase _getProductDetailUseCase;
  final AddToCartUseCase _addToCartUseCase;

  const AddLookProductToCartUseCase(
    this._getProductDetailUseCase,
    this._addToCartUseCase,
  );

  Future<ApiResult<void>> call({
    required String productSlug,
    required String productId,
    required int? colorId,
    required String? sizeLabel,
    int quantity = 1,
  }) async {
    final identifier = productSlug.isNotEmpty ? productSlug : productId;
    final detailResult = await _getProductDetailUseCase(identifier);

    switch (detailResult) {
      case ApiFailure(:final failure):
        return ApiFailure(failure);
      case ApiSuccess(:final data):
        final effectiveColorId =
            colorId ?? (data.colors.firstOrNull?.id ?? 0);

        final matchedSize = data.sizes
                .where(
                  (s) =>
                      s.label.trim().toUpperCase() ==
                      sizeLabel?.trim().toUpperCase(),
                )
                .firstOrNull ??
            data.findDefaultSize(effectiveColorId) ??
            data.sizes.firstOrNull;

        final sizeId = matchedSize?.id ?? 0;

        final variant = data.getVariant(
          sizeId: sizeId,
          colorId: effectiveColorId,
        );

        final params = AddToCartParams(
          variantId: variant?.id ?? 0,
          productId: data.id,
          colorId: effectiveColorId,
          sizeId: sizeId,
          quantity: quantity,
        );

        return _addToCartUseCase(params);
    }
  }
}
