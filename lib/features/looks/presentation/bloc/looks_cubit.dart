import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/looks/domain/usecases/get_looks_usecase.dart';
import 'package:looks_loop/features/looks/presentation/bloc/looks_state.dart';

class LooksCubit extends Cubit<LooksState> {
  final GetLooksUseCase _getLooksUseCase;

  LooksCubit(this._getLooksUseCase) : super(const LooksInitial());

  Future<void> fetchLooks() async {
    emit(const LooksLoading());
    final result = await _getLooksUseCase();

    switch (result) {
      case ApiSuccess(:final data):
        emit(LooksLoaded(data));
      case ApiFailure(:final failure):
        emit(LooksError(failure.message));
    }
  }
}
