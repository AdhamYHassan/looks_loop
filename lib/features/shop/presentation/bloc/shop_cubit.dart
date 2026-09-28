import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/usecases/get_shop_feed_usecase.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final GetShopFeedUseCase _getShopFeedUseCase;

  ShopCubit(this._getShopFeedUseCase) : super(const ShopInitial());

  Future<void> fetchShopFeed() async {
    emit(const ShopLoading());
    final result = await _getShopFeedUseCase();
    switch (result) {
      case ApiSuccess(:final data):
        emit(ShopLoaded(feedData: data));
      case ApiFailure(:final failure):
        emit(ShopError(failure.message));
    }
  }

  void selectAudience(String audienceId) {
    if (state is ShopLoaded) {
      final current = state as ShopLoaded;
      emit(current.copyWith(selectedAudienceId: audienceId));
    }
  }

  void selectQuickLink(String quickLink) {
    if (state is ShopLoaded) {
      final current = state as ShopLoaded;
      emit(current.copyWith(selectedQuickLink: quickLink));
    }
  }

  void toggleWishlist(String productId) {
    if (state is ShopLoaded) {
      final current = state as ShopLoaded;
      final updated = Set<String>.from(current.wishlistedProductIds);
      if (updated.contains(productId)) {
        updated.remove(productId);
      } else {
        updated.add(productId);
      }
      emit(current.copyWith(wishlistedProductIds: updated));
    }
  }
}
