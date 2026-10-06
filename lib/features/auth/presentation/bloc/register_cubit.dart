import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';
import 'package:looks_loop/features/auth/domain/usecases/register_usecase.dart';
import 'package:looks_loop/features/auth/presentation/bloc/register_state.dart';

/// Cubit managing registration state transitions.
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(const RegisterInitial());

  Future<void> register(RegisterParams params) async {
    emit(const RegisterLoading());

    final result = await _registerUseCase(params);

    switch (result) {
      case ApiSuccess(:final data):
        emit(RegisterSuccess(data));
      case ApiFailure(:final failure):
        emit(RegisterError(failure.message));
    }
  }
}
