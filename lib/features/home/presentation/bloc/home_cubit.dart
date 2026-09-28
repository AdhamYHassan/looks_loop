import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeFeedUseCase _getHomeFeedUseCase;

  HomeCubit(this._getHomeFeedUseCase) : super(const HomeInitial());

  Future<void> fetchHomeFeed() async {
    emit(const HomeLoading());

    final result = await _getHomeFeedUseCase();

    switch (result) {
      case ApiSuccess(:final data):
        emit(HomeLoaded(feedData: data));
      case ApiFailure(:final failure):
        emit(HomeError(failure.message));
    }
  }

  void toggleWishlist(String productId) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final updatedIds = Set<String>.from(currentState.wishlistedProductIds);
      if (updatedIds.contains(productId)) {
        updatedIds.remove(productId);
      } else {
        updatedIds.add(productId);
      }
      emit(currentState.copyWith(wishlistedProductIds: updatedIds));
    }
  }
}
