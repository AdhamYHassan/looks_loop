import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/watch_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final GetWishlistUseCase _getWishlistUseCase;
  final AddToWishlistUseCase _addToWishlistUseCase;
  final RemoveFromWishlistUseCase _removeFromWishlistUseCase;
  final WatchWishlistUseCase _watchWishlistUseCase;

  StreamSubscription<List<ProductEntity>>? _subscription;

  WishlistCubit(
    this._getWishlistUseCase,
    this._addToWishlistUseCase,
    this._removeFromWishlistUseCase,
    this._watchWishlistUseCase,
  ) : super(const WishlistInitial()) {
    _subscription = _watchWishlistUseCase().listen((items) {
      if (state is WishlistLoaded || state is WishlistInitial) {
        emit(WishlistLoaded(items: List<ProductEntity>.from(items)));
      }
    });
  }

  Future<void> fetchWishlist() async {
    emit(const WishlistLoading());
    final result = await _getWishlistUseCase();

    switch (result) {
      case ApiSuccess(:final data):
        emit(WishlistLoaded(items: List<ProductEntity>.from(data)));
      case ApiFailure(:final failure):
        emit(WishlistError(failure.message));
    }
  }

  Future<void> addItem(ProductEntity product) async {
    final currentState = state;
    if (currentState is WishlistLoaded) {
      if (!currentState.items.any((item) => item.id == product.id)) {
        emit(WishlistLoaded(items: [...currentState.items, product]));
      }
    }

    final result = await _addToWishlistUseCase(product);
    if (result is ApiFailure) {
      if (currentState is WishlistLoaded) {
        emit(currentState);
      }
      emit(WishlistError(result.failure.message));
    }
  }

  Future<void> removeItem(String productId) async {
    final currentState = state;
    if (currentState is WishlistLoaded) {
      final updatedList = currentState.items
          .where((item) => item.id.trim() != productId.trim())
          .toList();
      emit(WishlistLoaded(items: updatedList));
    }

    final result = await _removeFromWishlistUseCase(productId);
    if (result is ApiFailure) {
      if (currentState is WishlistLoaded) {
        emit(currentState);
      }
      emit(WishlistError(result.failure.message));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
