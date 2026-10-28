import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/data/datasources/more_local_data_source.dart';
import 'package:looks_loop/features/more/data/datasources/more_remote_data_source.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';
import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';
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
      final profile = await _localDataSource.getUserProfile();
      return ApiSuccess(profile);
    } catch (e) {
      return ApiFailure(UnknownFailure(e.toString()));
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
