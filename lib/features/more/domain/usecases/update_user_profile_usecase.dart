import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/update_user_profile_params.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';

class UpdateUserProfileUseCase {
  final MoreRepository _repository;

  const UpdateUserProfileUseCase(this._repository);

  Future<ApiResult<UserProfileEntity>> call(UpdateUserProfileParams params) async {
    return await _repository.updateUserProfile(params);
  }
}

