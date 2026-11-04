import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/data/datasources/more_local_data_source.dart';
import 'package:looks_loop/features/more/data/datasources/more_remote_data_source.dart';
import 'package:looks_loop/features/more/data/models/update_user_profile_request_model.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';
import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';
import 'package:looks_loop/features/more/domain/entities/update_user_profile_params.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';

class MoreRepositoryImpl implements MoreRepository {
  final MoreLocalDataSource _localDataSource;
  final MoreRemoteDataSource _remoteDataSource;

  const MoreRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  @override
  Future<ApiResult<UserProfileEntity>> getUserProfile() async {
    try {
      final token = await _localDataSource.getToken();
      if (token == null || token.trim().isEmpty) {
        final local = await _localDataSource.getUserProfile();
        return ApiSuccess(local);
      }
      final model = await _remoteDataSource.getUserProfile();
      await _localDataSource.saveUserProfile(model);
      return ApiSuccess(model);
    } catch (e) {
      try {
        final localProfile = await _localDataSource.getUserProfile();
        return ApiSuccess(localProfile);
      } catch (localError) {
        return ApiFailure(NetworkExceptions.getFailure(localError));
      }
    }
  }

  @override
  Future<ApiResult<UserProfileEntity>> updateUserProfile(
    UpdateUserProfileParams params,
  ) async {
    try {
      final request = UpdateUserProfileRequestModel.fromEntity(params);
      final model = await _remoteDataSource.updateUserProfile(request);
      await _localDataSource.saveUserProfile(model);
      return ApiSuccess(model);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<AppInfoEntity>> getAboutUs() async {
    try {
      final model = await _remoteDataSource.getAboutUs();
      return ApiSuccess(model);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<AppInfoEntity>> getPolicy() async {
    try {
      final model = await _remoteDataSource.getPolicy();
      return ApiSuccess(model);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<ContactUsEntity>> getContactUs() async {
    try {
      final model = await _remoteDataSource.getContactUs();
      return ApiSuccess(model);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
