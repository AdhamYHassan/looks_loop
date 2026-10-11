import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_state.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/watch_wishlist_usecase.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeFeedUseCase _getHomeFeedUseCase;
  final AddToWishlistUseCase _addToWishlistUseCase;
  final RemoveFromWishlistUseCase _removeFromWishlistUseCase;
  final WatchWishlistUseCase _watchWishlistUseCase;

  StreamSubscription<List<ProductEntity>>? _wishlistSubscription;

  HomeCubit(
    this._getHomeFeedUseCase,
    this._addToWishlistUseCase,
    this._removeFromWishlistUseCase,
    this._watchWishlistUseCase,
  ) : super(const HomeInitial()) {
    _wishlistSubscription = _watchWishlistUseCase().listen((wishlistItems) {
      final currentState = state;
      if (currentState is HomeLoaded) {
        final syncedIds = wishlistItems.map((item) => item.id).toSet();
        emit(currentState.copyWith(wishlistedProductIds: syncedIds));
      }
    });
  }

  Future<void> fetchHomeFeed() async {
    emit(const HomeLoading());

    final result = await _getHomeFeedUseCase();

    switch (result) {
      case ApiSuccess(:final data):
        final initialWishlist = {
          ...data.newInProducts.where((p) => p.isWishlisted).map((p) => p.id),
          ...data.saleProducts.where((p) => p.isWishlisted).map((p) => p.id),
          ...data.trendingProducts.where((p) => p.isWishlisted).map((p) => p.id),
        };
        emit(HomeLoaded(
          feedData: data,
          wishlistedProductIds: initialWishlist,
        ));
      case ApiFailure(:final failure):
        emit(HomeError(failure.message));
    }
  }

  Future<void> toggleWishlist(String productId) async {
    final currentState = state;
    if (currentState is! HomeLoaded) return;

    final isCurrentlyWishlisted =
        currentState.wishlistedProductIds.contains(productId);

    if (isCurrentlyWishlisted) {
      await _removeFromWishlistUseCase(productId);
    } else {
      ProductEntity? found;
      for (final p in currentState.feedData.newInProducts) {
        if (p.id == productId) {
          found = p;
          break;
        }
      }
      if (found == null) {
        for (final p in currentState.feedData.saleProducts) {
          if (p.id == productId) {
            found = p;
            break;
          }
        }
      }
      if (found == null) {
        for (final p in currentState.feedData.trendingProducts) {
          if (p.id == productId) {
            found = p;
            break;
          }
        }
      }

      if (found != null) {
        await _addToWishlistUseCase(found);
      }
    }
  }

  @override
  Future<void> close() {
    _wishlistSubscription?.cancel();
    return super.close();
  }
}
