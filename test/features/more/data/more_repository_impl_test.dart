import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/data/datasources/more_local_data_source.dart';
import 'package:looks_loop/features/more/data/datasources/more_remote_data_source.dart';
import 'package:looks_loop/features/more/data/models/app_info_model.dart';
import 'package:looks_loop/features/more/data/models/contact_us_model.dart';
import 'package:looks_loop/features/more/data/repositories/more_repository_impl.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';
import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

class FakeMoreLocalDataSource implements MoreLocalDataSource {
  final bool shouldThrow;

  const FakeMoreLocalDataSource({this.shouldThrow = false});

  @override
  Future<UserProfileEntity> getUserProfile() async {
    if (shouldThrow) {
      throw Exception('Database error');
    }
    return const UserProfileEntity.guest();
  }
}

class FakeMoreRemoteDataSource implements MoreRemoteDataSource {
  final bool shouldThrow;

  const FakeMoreRemoteDataSource({this.shouldThrow = false});

  @override
  Future<AppInfoModel> getAboutUs() async {
    if (shouldThrow) throw Exception('Network error');
    return const AppInfoModel(id: 1, title: 'About Us', content: 'Our Story');
  }

  @override
  Future<AppInfoModel> getPolicy() async {
    if (shouldThrow) throw Exception('Network error');
    return const AppInfoModel(id: 2, title: 'Policy', content: 'Privacy Policy');
  }

  @override
  Future<ContactUsModel> getContactUs() async {
    if (shouldThrow) throw Exception('Network error');
    return const ContactUsModel(id: 1, mobile: '+123456789');
  }
}

void main() {
  test('MoreRepositoryImpl returns ApiSuccess when local data source succeeds', () async {
    final repository = MoreRepositoryImpl(
      const FakeMoreLocalDataSource(),
      const FakeMoreRemoteDataSource(),
    );
    final result = await repository.getUserProfile();

    expect(result, isA<ApiSuccess<UserProfileEntity>>());
    expect((result as ApiSuccess<UserProfileEntity>).data.isGuest, true);
  });

  test('MoreRepositoryImpl catches local exception and returns ApiFailure', () async {
    final repository = MoreRepositoryImpl(
      const FakeMoreLocalDataSource(shouldThrow: true),
      const FakeMoreRemoteDataSource(),
    );
    final result = await repository.getUserProfile();

    expect(result, isA<ApiFailure<UserProfileEntity>>());
    final failure = (result as ApiFailure<UserProfileEntity>).failure;
    expect(failure, isA<UnknownFailure>());
    expect(failure.message, contains('Database error'));
  });

  test('MoreRepositoryImpl returns ApiSuccess for getAboutUs', () async {
    final repository = MoreRepositoryImpl(
      const FakeMoreLocalDataSource(),
      const FakeMoreRemoteDataSource(),
    );
    final result = await repository.getAboutUs();

    expect(result, isA<ApiSuccess<AppInfoEntity>>());
    expect((result as ApiSuccess<AppInfoEntity>).data.title, 'About Us');
  });

  test('MoreRepositoryImpl returns ApiSuccess for getPolicy', () async {
    final repository = MoreRepositoryImpl(
      const FakeMoreLocalDataSource(),
      const FakeMoreRemoteDataSource(),
    );
    final result = await repository.getPolicy();

    expect(result, isA<ApiSuccess<AppInfoEntity>>());
    expect((result as ApiSuccess<AppInfoEntity>).data.title, 'Policy');
  });

  test('MoreRepositoryImpl returns ApiSuccess for getContactUs', () async {
    final repository = MoreRepositoryImpl(
      const FakeMoreLocalDataSource(),
      const FakeMoreRemoteDataSource(),
    );
    final result = await repository.getContactUs();

    expect(result, isA<ApiSuccess<ContactUsEntity>>());
    expect((result as ApiSuccess<ContactUsEntity>).data.mobile, '+123456789');
  });
}
