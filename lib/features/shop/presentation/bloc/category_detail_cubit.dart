import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/usecases/get_category_detail_usecase.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_state.dart';

class CategoryDetailCubit extends Cubit<CategoryDetailState> {
  final GetCategoryDetailUseCase _getCategoryDetailUseCase;

  CategoryDetailCubit(this._getCategoryDetailUseCase)
      : super(const CategoryDetailInitial());

  Future<void> loadCategoryDetail(String audienceId) async {
    emit(const CategoryDetailLoading());
    final result = await _getCategoryDetailUseCase(audienceId);
    switch (result) {
      case ApiSuccess(:final data):
        emit(CategoryDetailLoaded(data: data));
      case ApiFailure(:final failure):
        emit(CategoryDetailError(failure.message));
    }
  }

  void toggleWishlist(String productId) {
    if (state is CategoryDetailLoaded) {
      final current = state as CategoryDetailLoaded;
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
