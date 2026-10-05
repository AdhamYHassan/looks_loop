import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/data/datasources/more_local_data_source.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';

class MoreRepositoryImpl implements MoreRepository {
  final MoreLocalDataSource _localDataSource;

  const MoreRepositoryImpl(this._localDataSource);

  @override
  Future<ApiResult<UserProfileEntity>> getUserProfile() async {
    try {
      final profile = await _localDataSource.getUserProfile();
      return ApiSuccess(profile);
    } catch (e) {
      return ApiFailure(UnknownFailure(e.toString()));
    }
  }
}
