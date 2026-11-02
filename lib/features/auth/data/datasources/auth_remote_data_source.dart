import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/auth/data/models/auth_response_model.dart';
import 'package:looks_loop/features/auth/data/models/login_request_model.dart';
import 'package:looks_loop/features/auth/data/models/register_request_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel request);
  Future<AuthResponseModel> register(RegisterRequestModel request);
  Future<void> logout(String refreshToken);
  Future<void> deleteAccount(String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final InetworkHelper _networkHelper;

  const AuthRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    final response = await _networkHelper.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    final response = await _networkHelper.post(
      ApiEndpoints.register,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout(String refreshToken) async {
    await _networkHelper.post(
      ApiEndpoints.logout,
      data: {'refresh': refreshToken},
    );
  }

  @override
  Future<void> deleteAccount(String password) async {
    await _networkHelper.delete(
      ApiEndpoints.deleteAccount,
      data: {'password': password},
    );
  }
}
