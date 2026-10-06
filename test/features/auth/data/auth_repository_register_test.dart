import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:looks_loop/features/auth/data/models/auth_response_model.dart';
import 'package:looks_loop/features/auth/data/models/auth_tokens_model.dart';
import 'package:looks_loop/features/auth/data/models/auth_user_model.dart';
import 'package:looks_loop/features/auth/data/models/login_request_model.dart';
import 'package:looks_loop/features/auth/data/models/register_request_model.dart';
import 'package:looks_loop/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';

class FakeRemoteDataSource implements AuthRemoteDataSource {
  final AuthResponseModel responseModel;

  const FakeRemoteDataSource(this.responseModel);

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async =>
      responseModel;

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

  const dummyResponseModel = AuthResponseModel(
    user: AuthUserModel(
      id: 99,
      phone: '+201001234567',
      phoneLocal: '01001234567',
      name: 'Ahmed Medhat',
      email: 'ahmed@test.com',
      preferredLanguage: 'en',
    ),
    tokens: AuthTokensModel(
      access: 'access_sample_token',
      refresh: 'refresh_sample_token',
    ),
  );

  test('AuthRepositoryImpl.register saves tokens for auto-login and returns success entity',
      () async {
    final remoteDataSource = FakeRemoteDataSource(dummyResponseModel);
    final repo = AuthRepositoryImpl(remoteDataSource);

    const params = RegisterParams(
      phone: '+201001234567',
      password: 'password123',
      name: 'Ahmed Medhat',
      email: 'ahmed@test.com',
      gender: 'male',
      birthday: '2026-10-06',
    );

    final result = await repo.register(params);

    expect(result, isA<ApiSuccess<AuthResponseEntity>>());
    final entity = (result as ApiSuccess<AuthResponseEntity>).data;
    expect(entity.user.name, equals('Ahmed Medhat'));
    expect(entity.tokens.access, equals('access_sample_token'));
  });

  test('AuthRepositoryImpl.register correctly maps DioException 400 with phone error to user message',
      () async {
    final dioError = DioException(
      requestOptions: RequestOptions(path: '/auth/register/'),
      response: Response(
        requestOptions: RequestOptions(path: '/auth/register/'),
        statusCode: 400,
        data: {
          'phone': ['This mobile number is already registered.']
        },
      ),
      type: DioExceptionType.badResponse,
    );

    final remoteDataSource = FakeErrorRemoteDataSource(dioError);
    final repo = AuthRepositoryImpl(remoteDataSource);

    const params = RegisterParams(
      phone: '+201001234567',
      password: 'password123',
      name: 'Ahmed Medhat',
      email: 'ahmed@test.com',
    );

    final result = await repo.register(params);

    expect(result, isA<ApiFailure<AuthResponseEntity>>());
    final failure = (result as ApiFailure<AuthResponseEntity>).failure;
    expect(failure.message, equals('This mobile number is already registered.'));
  });
}

class FakeErrorRemoteDataSource implements AuthRemoteDataSource {
  final Object error;

  FakeErrorRemoteDataSource(this.error);

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async =>
      throw error;

  @override
  Future<AuthResponseModel> register(RegisterRequestModel request) async =>
      throw error;

  @override
  Future<void> logout(String refreshToken) async => throw error;
}
