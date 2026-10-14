import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/helpers/secure_storage_helper.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:looks_loop/features/auth/data/models/auth_response_model.dart';
import 'package:looks_loop/features/auth/data/models/auth_tokens_model.dart';
import 'package:looks_loop/features/auth/data/models/auth_user_model.dart';
import 'package:looks_loop/features/auth/data/models/login_request_model.dart';
import 'package:looks_loop/features/auth/data/models/register_request_model.dart';
import 'package:looks_loop/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';

class FakeCaptureLoginDataSource implements AuthRemoteDataSource {
  final AuthResponseModel responseModel;
  final void Function(LoginRequestModel request) onLogin;

  const FakeCaptureLoginDataSource(this.responseModel, {required this.onLogin});

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    onLogin(request);
    return responseModel;
  }

  @override
  Future<AuthResponseModel> register(RegisterRequestModel request) async =>
      responseModel;

  @override
  Future<void> logout(String refreshToken) async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  const dummyResponse = AuthResponseModel(
    user: AuthUserModel(
      id: 99,
      phone: '+201001234567',
      phoneLocal: '01001234567',
      name: 'Ahmed',
      email: 'ahmed@test.com',
      preferredLanguage: 'en',
    ),
    tokens: AuthTokensModel(
      access: 'access_123',
      refresh: 'refresh_123',
    ),
  );

  test('AuthRepositoryImpl.login includes stored cart_token and clears it on success',
      () async {
    LoginRequestModel? captured;
    final ds = FakeCaptureLoginDataSource(
      dummyResponse,
      onLogin: (req) => captured = req,
    );
    final repo = AuthRepositoryImpl(ds);

    await SecureStorageHelper.saveCartToken('app_d12ec900ead7f104c42d806f51ffe5d3');

    final result = await repo.login(
      phone: '+201001234567',
      password: 'password123',
    );

    expect(result, isA<ApiSuccess<AuthResponseEntity>>());
    expect(captured?.phone, '+201001234567');
    expect(captured?.password, 'password123');
    expect(captured?.cartToken, 'app_d12ec900ead7f104c42d806f51ffe5d3');

    // Token must be cleared from secure storage
    final storedToken = await SecureStorageHelper.getCartToken();
    expect(storedToken, isNull);
  });
}
