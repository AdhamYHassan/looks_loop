import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final GetWishlistUseCase _getWishlistUseCase;
  final RemoveFromWishlistUseCase _removeFromWishlistUseCase;

  WishlistCubit(
    this._getWishlistUseCase,
    this._removeFromWishlistUseCase,
  ) : super(const WishlistInitial());

  Future<void> fetchWishlist() async {
    emit(const WishlistLoading());
    final result = await _getWishlistUseCase();

    switch (result) {
      case ApiSuccess(:final data):
        emit(WishlistLoaded(items: data));
      case ApiFailure(:final failure):
        emit(WishlistError(failure.message));
    }
  }

  Future<void> removeItem(String productId) async {
    final currentState = state;
    if (currentState is! WishlistLoaded) return;

    final optimisticList =
        currentState.items.where((item) => item.id != productId).toList();
    emit(WishlistLoaded(items: optimisticList));

    final result = await _removeFromWishlistUseCase(productId);
    switch (result) {
      case ApiSuccess(:final data):
        emit(WishlistLoaded(items: data));
      case ApiFailure(:final failure):
        emit(WishlistError(failure.message));
    }
  }
}
