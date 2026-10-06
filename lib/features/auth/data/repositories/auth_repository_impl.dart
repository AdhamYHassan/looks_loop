import 'package:dio/dio.dart';
import 'package:looks_loop/core/helpers/secure_storage_helper.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:looks_loop/features/auth/data/models/login_request_model.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<AuthResponseEntity>> login({
    required String phone,
    required String password,
    String? cartToken,
  }) async {
    try {
      final effectiveCartToken =
          cartToken ?? await SecureStorageHelper.getCartToken();
      final request = LoginRequestModel(
        phone: phone,
        password: password,
        cartToken: effectiveCartToken,
      );

      final responseModel = await _remoteDataSource.login(request);

      await SecureStorageHelper.saveToken(responseModel.tokens.access);
      await SecureStorageHelper.saveRefreshToken(responseModel.tokens.refresh);
      await SecureStorageHelper.savePhoneNumber(responseModel.user.phone);
      await SecureStorageHelper.saveUserName(responseModel.user.name);
      await SecureStorageHelper.saveUserEmail(responseModel.user.email);

      return ApiSuccess(responseModel.toEntity());
    } on DioException catch (e) {
      final message = e.response?.data is Map
          ? (e.response?.data['message'] ?? e.message ?? 'Server error')
          : (e.message ?? 'Server error');
      return ApiFailure(
        ServerFailure(message.toString(), statusCode: e.response?.statusCode),
      );
    } catch (e) {
      return ApiFailure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> logout() async {
    try {
      final refreshToken = await SecureStorageHelper.getRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await _remoteDataSource.logout(refreshToken);
      }

      await SecureStorageHelper.clearToken();
      await SecureStorageHelper.clearRefreshToken();
      await SecureStorageHelper.clearAll();

      return const ApiSuccess(null);
    } on DioException catch (e) {
      await SecureStorageHelper.clearAll();
      final message = e.response?.data is Map
          ? (e.response?.data['message'] ?? e.message ?? 'Server error')
          : (e.message ?? 'Server error');
      return ApiFailure(
        ServerFailure(message.toString(), statusCode: e.response?.statusCode),
      );
    } catch (e) {
      await SecureStorageHelper.clearAll();
      return ApiFailure(UnknownFailure(e.toString()));
    }
  }
}
