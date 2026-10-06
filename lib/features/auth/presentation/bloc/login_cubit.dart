import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/usecases/login_usecase.dart';
import 'package:looks_loop/features/auth/presentation/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginInitial());

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(const LoginLoading());

    final result = await _loginUseCase(
      phone: phone,
      password: password,
    );

    switch (result) {
      case ApiSuccess(:final data):
        emit(LoginSuccess(data));
      case ApiFailure(:final failure):
        emit(LoginError(failure.message));
    }
  }
}
