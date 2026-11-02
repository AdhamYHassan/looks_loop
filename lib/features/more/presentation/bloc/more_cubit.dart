import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/auth/auth_status_cubit.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:looks_loop/features/auth/domain/usecases/logout_usecase.dart';
import 'package:looks_loop/features/more/domain/usecases/get_user_profile_usecase.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final LogoutUseCase _logoutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final AuthStatusCubit _authStatusCubit;

  MoreCubit(
    this._getUserProfileUseCase,
    this._logoutUseCase,
    this._deleteAccountUseCase,
    this._authStatusCubit,
  ) : super(const MoreInitial());

  Future<void> loadUserProfile() async {
    emit(const MoreLoading());
    final result = await _getUserProfileUseCase();

    switch (result) {
      case ApiSuccess(:final data):
        if (data.isGuest) {
          _authStatusCubit.setGuest();
        } else {
          _authStatusCubit.setAuthenticated(data);
        }
        emit(MoreLoaded(profile: data));
      case ApiFailure(:final failure):
        emit(MoreError(failure.message));
    }
  }

  Future<void> logout() async {
    emit(const MoreLoading());
    await _logoutUseCase();
    _authStatusCubit.setGuest();
    await loadUserProfile();
  }

  Future<ApiResult<void>> deleteAccount(String password) async {
    emit(const MoreLoading());
    final result = await _deleteAccountUseCase(password);
    if (result is ApiSuccess) {
      _authStatusCubit.setGuest();
    }
    await loadUserProfile();
    return result;
  }
}
