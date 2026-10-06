import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';

abstract interface class AuthRepository {
  Future<ApiResult<AuthResponseEntity>> login({
    required String phone,
    required String password,
    String? cartToken,
  });

  Future<ApiResult<AuthResponseEntity>> register(RegisterParams params);

  Future<ApiResult<void>> logout();
}
