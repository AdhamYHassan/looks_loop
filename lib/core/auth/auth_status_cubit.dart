import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/auth/auth_status_state.dart';
import 'package:looks_loop/core/helpers/safe_emit_mixin.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/usecases/get_user_profile_usecase.dart';

class AuthStatusCubit extends Cubit<AuthStatusState>
    with SafeEmitMixin<AuthStatusState> {
  final GetUserProfileUseCase _getUserProfileUseCase;

  AuthStatusCubit(this._getUserProfileUseCase)
      : super(const AuthStatusInitial());

  Future<void> checkAuthStatus() async {
    final result = await _getUserProfileUseCase();
    switch (result) {
      case ApiSuccess(:final data):
        if (data.isGuest) {
          emit(const AuthStatusGuest());
        } else {
          emit(AuthStatusAuthenticated(data));
        }
      case ApiFailure():
        emit(const AuthStatusGuest());
    }
  }

  void setAuthenticated(UserProfileEntity user) {
    emit(AuthStatusAuthenticated(user));
  }

  void setGuest() {
    emit(const AuthStatusGuest());
  }
}

