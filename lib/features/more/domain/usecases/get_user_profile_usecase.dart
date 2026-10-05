import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';

class GetUserProfileUseCase {
  final MoreRepository _repository;

  const GetUserProfileUseCase(this._repository);

  Future<ApiResult<UserProfileEntity>> call() async {
    return await _repository.getUserProfile();
  }
}
