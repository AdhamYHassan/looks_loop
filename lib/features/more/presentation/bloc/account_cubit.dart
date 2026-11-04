import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/auth/auth_status_cubit.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/update_user_profile_params.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/usecases/get_user_profile_usecase.dart';
import 'package:looks_loop/features/more/domain/usecases/update_user_profile_usecase.dart';
import 'package:looks_loop/features/more/presentation/bloc/account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final AuthStatusCubit _authStatusCubit;

  AccountCubit(
    this._getUserProfileUseCase,
    this._updateUserProfileUseCase,
    this._authStatusCubit,
  ) : super(const AccountInitial());

  UserProfileEntity? _currentProfile;

  Future<void> fetchProfile() async {
    emit(const AccountLoading());
    final result = await _getUserProfileUseCase();
    switch (result) {
      case ApiSuccess(data: final profile):
        _currentProfile = profile;
        _authStatusCubit.setAuthenticated(profile);
        emit(AccountLoaded(profile));
      case ApiFailure(failure: final failure):
        emit(AccountError(failure.message));
    }
  }

  Future<void> updateProfile(UpdateUserProfileParams params) async {
    final existing = _currentProfile ??
        UserProfileEntity(
          name: params.name,
          email: params.email,
          phone: params.phone,
          gender: params.gender,
          birthday: params.birthday,
        );
    emit(AccountUpdating(existing));

    final result = await _updateUserProfileUseCase(params);
    switch (result) {
      case ApiSuccess(data: final updatedProfile):
        _currentProfile = updatedProfile;
        _authStatusCubit.setAuthenticated(updatedProfile);
        emit(AccountUpdateSuccess(updatedProfile));
        emit(AccountLoaded(updatedProfile));
      case ApiFailure(failure: final failure):
        emit(AccountError(failure.message));
        if (_currentProfile != null) {
          emit(AccountLoaded(_currentProfile!));
        }
    }
  }
}
