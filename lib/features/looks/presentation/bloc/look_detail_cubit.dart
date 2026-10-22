import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/featured_look_entity.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/looks/domain/usecases/add_look_product_to_cart_usecase.dart';
import 'package:looks_loop/features/looks/domain/usecases/get_look_detail_usecase.dart';
import 'package:looks_loop/features/looks/presentation/bloc/look_detail_state.dart';

class LookDetailCubit extends Cubit<LookDetailState> {
  final GetLookDetailUseCase _getLookDetailUseCase;
  final AddLookProductToCartUseCase? _addLookProductToCartUseCase;

  LookDetailCubit(
    this._getLookDetailUseCase, [
    this._addLookProductToCartUseCase,
  ]) : super(const LookDetailInitial());

  void initWithLook(FeaturedLookEntity look) {
    emit(LookDetailLoaded(look));
  }

  Future<void> fetchLookDetail(String slug) async {
    emit(const LookDetailLoading());
    final result = await _getLookDetailUseCase(slug);

    switch (result) {
      case ApiSuccess(:final data):
        emit(LookDetailLoaded(data));
      case ApiFailure(:final failure):
        emit(LookDetailError(failure.message));
    }
  }

  Future<void> addProductToBag({
    required ProductEntity product,
    required int? colorId,
    required String? size,
  }) async {
    if (_addLookProductToCartUseCase == null) return;
    final curr = state;
    if (curr is! LookDetailLoaded) return;
    if (curr.addingProductId != null) return;

    emit(curr.copyWith(
      addingProductId: () => product.id,
      bagActionMessage: () => null,
    ));

    final result = await _addLookProductToCartUseCase(
      productSlug: product.slug,
      productId: product.id,
      colorId: colorId,
      sizeLabel: size,
    );

    if (isClosed) return;

    switch (result) {
      case ApiSuccess():
        emit(curr.copyWith(
          addingProductId: () => null,
          bagActionMessage: () => 'Added ${product.name} to bag',
        ));
      case ApiFailure(:final failure):
        emit(curr.copyWith(
          addingProductId: () => null,
          bagActionMessage: () => failure.message,
        ));
    }
  }

  void clearBagActionMessage() {
    final curr = state;
    if (curr is LookDetailLoaded && curr.bagActionMessage != null) {
      emit(curr.copyWith(bagActionMessage: () => null));
    }
  }
}
