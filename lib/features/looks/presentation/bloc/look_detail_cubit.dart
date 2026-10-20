import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/featured_look_entity.dart';
import 'package:looks_loop/features/looks/domain/usecases/get_look_detail_usecase.dart';
import 'package:looks_loop/features/looks/presentation/bloc/look_detail_state.dart';

class LookDetailCubit extends Cubit<LookDetailState> {
  final GetLookDetailUseCase _getLookDetailUseCase;

  LookDetailCubit(this._getLookDetailUseCase)
      : super(const LookDetailInitial());

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
}
